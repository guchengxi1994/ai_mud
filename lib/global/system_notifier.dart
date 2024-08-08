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

  SystemState({
    required this.type,
    required this.worldSetting,
    required this.systemId,
  });
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
      throw ArgumentError("输入的正整数必须大于零");
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

class SystemNotifier extends Notifier<SystemState?> {
  final IsarDatabase database = IsarDatabase();
  final AiClient client = AiClient();
  static Random random = Random();

  @override
  SystemState? build() {
    return null;
  }

  Future loadLast() async {
    final last =
        await database.isar!.systems.where().sortByCreateAtDesc().findFirst();
    if (last != null) {
      state = SystemState(
        type: last.type,
        worldSetting: last.worldSetting,
        systemId: last.id,
      );
    }
  }

  Future newGame(NewGameState newGameConfig) async {
    /// TODO 这里要根据身份初始化属性
    /// 这里最好是用大模型生成，但是现在用随机

    Player player = Player()
      ..name = newGameConfig.playerName
      ..role = newGameConfig.playerRole
      ..maxAge = /* 随机的最大年龄，超过这个岁数游戏结束 */ random.nextInt(40) + 30;

    player.ability += PlayerAbility.getRandom();

    System system = System()
      ..type = newGameConfig.worldType
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

  Future<YearMonthPeriod?> getCurrentAge() async {
    if (state == null) {
      return null;
    }

    final historyLength = await database.isar!.systems
        .where()
        .idEqualTo(state!.systemId)
        .findFirst()
        .then((v) => v?.history.length);

    if (historyLength == null) {
      return null;
    }

    return YearMonthPeriod.calculateYearMonthPeriod(historyLength);
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

final systemProvider = NotifierProvider<SystemNotifier, SystemState?>(() {
  return SystemNotifier();
});
