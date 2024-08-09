import 'dart:convert';

import 'package:ai_mud/game/models/event.dart';
import 'package:ai_mud/global/ai_client.dart';
import 'package:ai_mud/global/system_notifier.dart';
import 'package:ai_mud/isar/database.dart';
import 'package:ai_mud/isar/system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langchain_lib/langchain_lib.dart';

class GameState {
  final String dialog;
  final bool conversationDone;

  GameState({this.dialog = "", this.conversationDone = false});

  GameState copyWith({String? dialog, bool? conversationDone}) {
    return GameState(
      dialog: dialog ?? this.dialog,
      conversationDone: conversationDone ?? this.conversationDone,
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

  @override
  GameState build() {
    return GameState();
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

    prompt.writeln(
        "玩家的名字是${system.player.value!.name},今年${yearMonthPeriod?.year ?? 1}岁，身份是一个${system.player.value!.role}");

    final stream = aiClient.stream([
      const SystemChatMessage(
          content: "你是一个单机的文字游戏（MUD游戏）。主要游戏建立在你与玩家互动的基础上，通过创建一些随机事件，让玩家得到提升。"),
      SystemChatMessage(content: prompt.toString()),
      ChatMessage.humanText(
          "请根据以上内容，随机生成一个事件。随机事件包括以下几个要点：1.事件名称，以四字或者六子短语为主；2.事件内容，150字以内；3.事件可能的选项，一般给两个到四个选项。以json返回，json格式如下: {\"eventname\": \"事件名称\", \"eventcontent\": \"事件内容\", \"eventoptions\": [\"选项1\", \"选项2\", \"选项3\", \"选项4\"]}"),
      ChatMessage.humanText("仅需要给出答案，不需要过程")
    ]);

    stream.listen((v) {
      state = state.copyWith(dialog: state.dialog + v.outputAsString);
      controller.jumpTo(controller.position.maxScrollExtent);
    }, onDone: () async {
      state = state.copyWith(conversationDone: true);
      if (onDone != null) {
        onDone(state.toEvent());
      }
    }, onError: (e) {
      state = state.copyWith(
          dialog: state.dialog + e.toString(), conversationDone: true);
      controller.jumpTo(controller.position.maxScrollExtent);
    }, cancelOnError: true);
  }
}

final gameProvider =
    AutoDisposeNotifierProvider<GameNotifier, GameState>(() => GameNotifier());
