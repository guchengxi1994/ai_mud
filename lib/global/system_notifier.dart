import 'dart:async';
import 'dart:math';

import 'package:ai_mud/global/global.dart';
import 'package:ai_mud/isar/chat_history.dart';
import 'package:ai_mud/isar/database.dart';
import 'package:ai_mud/isar/player.dart';
import 'package:ai_mud/isar/system.dart';
import 'package:ai_mud/opening/notifiers/new_game_notifier.dart'
    show NewGameState;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:langchain_lib/langchain_lib.dart';

typedef OnStreamDone = void Function();
typedef OnData = void Function(ChatResult);

class SystemState {
  final String type;
  final String worldSetting;
  final int systemId;
  final int historyLength;

  SystemState(
      {this.type = "",
      this.worldSetting = "",
      this.systemId = -1,
      this.historyLength = 0});

  SystemState copyWith({
    String? type,
    String? worldSetting,
    int? systemId,
    int? historyLength,
  }) {
    return SystemState(
      type: type ?? this.type,
      worldSetting: worldSetting ?? this.worldSetting,
      systemId: systemId ?? this.systemId,
      historyLength: historyLength ?? this.historyLength,
    );
  }
}

class YearMonthPeriod {
  final int year;
  final int month;
  final String period;

  YearMonthPeriod(this.year, this.month, this.period);

  @override
  String toString() {
    return '$year 年 $month 月 $period 旬';
  }

  static YearMonthPeriod calculateYearMonthPeriod(int input) {
    if (input <= 0) {
      input = 1;
    }

    // 每年有 12 个月，每个月有 3 旬
    int periodsPerYear = 12 * 3;

    // 计算年份
    int year = (input - 1) ~/ periodsPerYear + 1;

    // 计算总的旬数在一年中的位置
    int positionInYear = (input - 1) % periodsPerYear;

    // 计算月份
    int month = positionInYear ~/ 3 + 1;

    // 计算旬
    int periodIndex = positionInYear % 3;
    String period;
    if (periodIndex == 0) {
      period = '上';
    } else if (periodIndex == 1) {
      period = '中';
    } else {
      period = '下';
    }

    return YearMonthPeriod(year, month, period);
  }
}

class SystemNotifier extends Notifier<SystemState> {
  final IsarDatabase database = IsarDatabase();
  final AiClient client = AiClient();
  static Random random = Random();

  @override
  SystemState build() {
    return SystemState();
  }

  Future<bool> loadLast() async {
    final last =
        await database.isar!.systems.where().sortByCreateAtDesc().findFirst();
    if (last != null) {
      state = SystemState(
        type: last.type,
        worldSetting: last.worldSetting,
        systemId: last.id,
        historyLength: last.history.length,
      );
      return true;
    }

    return false;
  }

  Future<System> getCurrent() async {
    return (await database.isar!.systems
        .where()
        .idEqualTo(state.systemId)
        .findFirst())!;
  }

  System getCurrentSync() {
    return database.isar!.systems
        .where()
        .idEqualTo(state.systemId)
        .findFirstSync()!;
  }

  bool couldMoveNext() {
    final y = getCurrentAge();
    if (y == null) {
      return false;
    }

    final maxAge = getCurrentSync().player.value!.maxAge;

    return y.year < maxAge;
  }

  Future moveNext() async {
    if (!couldMoveNext()) {
      return;
    }

    if (state.systemId == -1) {
      return;
    }

    final historyLength = await database.isar!.systems
        .where()
        .idEqualTo(state.systemId)
        .findFirst()
        .then((v) => v?.history.length);

    state = state.copyWith(historyLength: historyLength!);
  }

  Future<bool> getHintShown() async {
    final system = await getCurrent();
    return system.hintShown;
  }

  Future setHintShown() async {
    await database.isar!.writeTxn(() async {
      final system = await getCurrent();
      system.hintShown = true;
      await database.isar!.systems.put(system);
    });
  }

  Future newGame(NewGameState newGameConfig) async {
    /// TODO 这里要根据身份初始化属性
    /// 这里最好是用大模型生成，但是现在用随机

    Player player = Player()
      ..name = newGameConfig.playerName
      ..role = newGameConfig.playerRole
      ..maxAge = /* 随机的最大年龄，超过这个岁数游戏结束 */ random.nextInt(40) + 30;

    player.ability += PlayerAbility.getRandom();
    player.aim = newGameConfig.aim;

    System system = System()
      ..type = newGameConfig.worldType
      ..details.add(newGameConfig.worldOption)
      ..worldSetting = newGameConfig.worldSetting;

    await database.isar!.writeTxn(() async {
      await database.isar!.players.put(player);
      await database.isar!.systems.put(system);

      system.player.value = player;
      await system.player.save();
    });

    state = SystemState(
      type: newGameConfig.worldType,
      worldSetting: newGameConfig.worldSetting,
      systemId: system.id,
    );
  }

  changePlayerMaxAge(int a) async {
    final system = await getCurrent();
    system.player.value!.maxAge = system.player.value!.maxAge + a;
    await database.isar!.writeTxn(() async {
      await database.isar!.players.put(system.player.value!);
    });
  }

  Future<PlayerAbility> getAbility() async {
    return (await getCurrent()).player.value?.ability ?? PlayerAbility();
  }

  PlayerAbility getAbilitySync() {
    return getCurrentSync().player.value?.ability ?? PlayerAbility();
  }

  YearMonthPeriod? getCurrentAge() {
    if (state.systemId == -1) {
      return null;
    }

    return YearMonthPeriod.calculateYearMonthPeriod(state.historyLength + 1);
  }

  Stream<ChatResult> generateWorld(
    String type,
    OnStreamDone? onDone, {
    String details = "",
    OnData? onData,
  }) async* {
    String response = "";
    int tokenCount = 0;
    await for (var v in client.stream([
      ChatMessage.system("主要游戏建立在你与玩家互动的基础上，通过创建一些随机事件，让玩家得到提升。"),
      ChatMessage.humanText("请帮我按照$type，设计游戏的世界观"),
      if (details.isNotEmpty) ChatMessage.humanText("具体要求如下: $details"),
      ChatMessage.humanText("仅需要给出答案，不需要过程")
    ])) {
      response += v.outputAsString;
      tokenCount += v.usage.totalTokens ?? 0;
      yield v;
      if (onData != null) {
        onData(v);
      }
    }

    if (onDone != null) {
      onDone();
    }

    await database.isar!.writeTxn(() async {
      await database.isar!.chatHistorys.put(ChatHistory()
        ..content = response
        ..tokenCount = tokenCount);
    });
  }
}

final systemProvider = NotifierProvider<SystemNotifier, SystemState>(() {
  return SystemNotifier();
});
