import 'package:isar/isar.dart';

part 'chat_history.g.dart';

@collection
class ChatHistory {
  Id id = Isar.autoIncrement;
  late int tokenCount = 0;
  late String content = "";
  int createAt = DateTime.now().millisecondsSinceEpoch;
}
