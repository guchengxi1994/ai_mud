import 'package:ai_mud/global/global.dart';
import 'package:ai_mud/isar/database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langchain_lib/langchain_lib.dart';

class SystemState {}

class SystemNotifier extends Notifier<SystemState?> {
  final IsarDatabase database = IsarDatabase();
  final AiClient client = AiClient();

  @override
  SystemState? build() {
    return null;
  }

  Stream<ChatResult> generateWorld(String type, {String details = ""}) {
    return client.stream([
      ChatMessage.system("你是一款文字游戏(MUD游戏)"),
      ChatMessage.humanText("请帮我按照$type，设计游戏的世界观"),
      if (details.isNotEmpty) ChatMessage.humanText("具体要求如下: $details"),
      ChatMessage.humanText("仅需要给出答案，不需要过程")
    ]);
  }
}

final systemProvider = NotifierProvider<SystemNotifier, SystemState?>(() {
  return SystemNotifier();
});
