import 'package:isar/isar.dart';

part 'openai_config_history.g.dart';

@collection
class OpenaiConfigHistory {
  Id id = Isar.autoIncrement;
  @Index(unique: true)
  late String name = "defalut";
  late String apiKey = "sk-";
  late String apiBaseUrl = "http://";
  late String model = "default";
  late double temperature = 0.7;
  @Index(unique: true)
  late String tag = "text-model";
}
