import 'package:isar/isar.dart';

part 'openai_config_history.g.dart';

const List<String> modelTypes = [
  "text-model",
  "vision-model",
  "image-model",
  "chat-model",
  "embedding-model",
  "audio-model",
  "code-model",
  "video-model",
  "translation-model",
  "speech-model",
  "text-generation-model",
  "text-embedding-model",
  "text-classification-model",
  "text-generation-model",
];

@collection
class OpenaiConfigHistory {
  Id id = Isar.autoIncrement;
  late String apiKey = "sk-";
  late String apiBaseUrl = "http://";
  late String model = "default";
  late double temperature = 0.7;
  @Index(unique: true)
  late String tag = "text-model";

  Map<String, dynamic> toJson() => {
        "llm-sk": apiKey,
        "llm-base": apiBaseUrl,
        "llm-model-name": model,
        "temperature": temperature,
        "tag": tag
      };

  OpenaiConfigHistory fromJson(Map<String, dynamic> json) {
    apiKey = json["llm-sk"];
    apiBaseUrl = json["llm-base"];
    model = json["llm-model-name"];
    temperature = json["temperature"] ?? 0.7;
    tag = json["tag"];
    return this;
  }
}
