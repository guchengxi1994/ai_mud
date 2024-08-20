import 'dart:convert';

import 'package:ai_mud/common/utils.dart';
import 'package:ai_mud/game/models/event.dart';
import 'package:ai_mud/global/global.dart';
import 'package:ai_mud/global/system_notifier.dart';
import 'package:ai_mud/isar/chat_history.dart';
import 'package:ai_mud/isar/database.dart';
import 'package:ai_mud/isar/player.dart';
import 'package:ai_mud/isar/system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langchain_lib/langchain_lib.dart';
// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';

class GameState {
  final String dialog;
  final bool conversationDone;
  final int token;

  GameState({this.dialog = "", this.conversationDone = false, this.token = 0});

  GameState copyWith({String? dialog, bool? conversationDone, int? token}) {
    return GameState(
      dialog: dialog ?? this.dialog,
      conversationDone: conversationDone ?? this.conversationDone,
      token: token ?? this.token,
    );
  }

  Event? toEvent() {
    try {
      return Event.fromJson(jsonDecode(dialog));
    } catch (e) {
      return null;
    }
  }
}

typedef OnDone = void Function(Event? e);

class GameNotifier extends AutoDisposeNotifier<GameState> {
  final AiClient aiClient = AiClient();
  final ScrollController controller = ScrollController();
  final IsarDatabase isarDatabase = IsarDatabase();
  late final SystemConfig config = aiClient.systemConfig;

  @override
  GameState build() {
    return GameState();
  }

  setError() {
    state = state.copyWith(
        dialog: "${state.dialog}\n\n\n系统错误，请重试(大模型有时候会无法返回正确结果，和作者无关😀)",
        conversationDone: true);
  }

  Future plot(System system, {OnDone? onDone}) async {
    state = state.copyWith(dialog: "", conversationDone: false);

    StringBuffer prompt = StringBuffer();
    prompt.writeln(system.prompt);

    for (final i in system.details) {
      prompt.writeln(i);
    }

    YearMonthPeriod? yearMonthPeriod =
        await ref.read(systemProvider.notifier).getCurrentAge();
    Set<String> history = await getHistory();

    StringBuffer historyList = StringBuffer();
    String lastHistory = await getLastHistory();

    history.mapIndexed((i, v) => historyList.writeln("事件$i：$v"));

    prompt.writeln(
        "玩家的名字是${system.player.value!.name},今年${yearMonthPeriod?.year ?? 1}岁，身份是一个${system.player.value!.role}");

    List<SystemChatMessage> systemRoles = [];

    for (final i in config.systemRole) {
      systemRoles.add(SystemChatMessage(content: i));
    }

    // print("config.common   ${config.common}");

    List<ChatMessage> userMessages =
        config.common.map((v) => ChatMessage.humanText(v)).toList();

    final stream = aiClient.stream([
      ...systemRoles,
      ChatMessage.humanText(prompt.toString()),
      ...userMessages,
      if (lastHistory != "")
        ChatMessage.humanText("注意：事件\"$lastHistory\"是上一个事件，请不要回答相同的事件。"),
      ChatMessage.humanText(
          "注意：以下事件已回答过，请不要重复回答！已经回答的事件清单如下： ${historyList.toString()}")
    ]);

    stream.listen((v) {
      state = state.copyWith(
          dialog: state.dialog + v.outputAsString,
          token: v.usage.totalTokens ?? 0 + state.token);
      controller.jumpTo(controller.position.maxScrollExtent);
    }, onDone: () async {
      state = state.copyWith(conversationDone: true);
      saveChatHistory();
      if (onDone != null) {
        onDone(state.toEvent());
      }
    }, onError: (e) {
      state = state.copyWith(
          dialog: state.dialog + e.toString(), conversationDone: true);
      controller.jumpTo(controller.position.maxScrollExtent);
      saveChatHistory();
    }, cancelOnError: true);
  }

  Future<Set<String>> getHistory() async {
    final s = (await ref.read(systemProvider.notifier).getCurrent())
        .history
        .map((v) => v.name)
        .toSet();

    s.remove("");

    logger.info("history: $s");
    return s;
  }

  Future<String> getLastHistory() async {
    final s = (await ref.read(systemProvider.notifier).getCurrent())
        .history
        .map((v) => v.name);
    if (s.isEmpty) {
      return "";
    }
    return s.last;
  }

  Future saveHistoryToIsar(Event e) async {
    PlayerAbility ability = PlayerAbility.fromString(e.result);
    History history = History()
      ..content = e.content
      ..name = e.name
      ..options = e.options.map((v) => v.content).toList()
      ..result = e.result;
    System system = await ref.read(systemProvider.notifier).getCurrent();
    system.history = [...system.history, history];

    system.player.value!.ability = system.player.value!.ability + ability;
    logger.info("ability adjust: $ability");

    await isarDatabase.isar!.writeTxn(() async {
      logger.info("ability after: ${system.player.value!.ability}");
      await isarDatabase.isar!.players.put(system.player.value!);
      await isarDatabase.isar!.systems.put(system);
    });

    ref.read(systemProvider.notifier).moveNext();
  }

  saveChatHistory() async {
    await isarDatabase.isar!.writeTxn(() async {
      ChatHistory chatHistory = ChatHistory()
        ..content = state.dialog
        ..tokenCount = state.token;
      await isarDatabase.isar!.chatHistorys.put(chatHistory);
    });
  }
}

final gameProvider =
    AutoDisposeNotifierProvider<GameNotifier, GameState>(() => GameNotifier());
