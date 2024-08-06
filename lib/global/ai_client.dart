import 'package:ai_mud/global/system.dart';
import 'package:langchain_lib/langchain_lib.dart';

class AiClient {
  AiClient._();

  static final _instance = AiClient._();

  factory AiClient() => _instance;

  late SystemConfig systemConfig;

  initOpenAi(String path) {
    OpenaiClient.fromEnv(path);
  }

  initSystemConfig(String path) {
    systemConfig = SystemConfig.fromPath(path);
  }

  Stream<ChatResult> stream(List<ChatMessage> history,
      {String tag = "text-model"}) {
    final client = OpenaiClient.getByTag(tag);
    return client!.stream(history);
  }
}
