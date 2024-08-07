import 'package:ai_mud/global/global.dart';
import 'package:ai_mud/isar/chat_history.dart';
import 'package:ai_mud/isar/database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langchain_lib/langchain_lib.dart';

typedef OnStreamDone = void Function();
typedef OnData = void Function(ChatResult);

class SystemState {}

class SystemNotifier extends Notifier<SystemState?> {
  final IsarDatabase database = IsarDatabase();
  final AiClient client = AiClient();

  @override
  SystemState? build() {
    return null;
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
      ChatMessage.system("你是一款文字游戏(MUD游戏)"),
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
