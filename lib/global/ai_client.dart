import 'package:langchain_lib/langchain_lib.dart';

class AiClient {
  AiClient._();

  static final _instance = AiClient._();

  factory AiClient() => _instance;

  initOpenAi(String path) {
    OpenaiClient.fromEnv(path);
  }
}
