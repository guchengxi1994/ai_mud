import 'package:ai_mud/game/models/event.dart';
import 'package:isar/isar.dart';

part 'saved_event.g.dart';

@collection
class SavedEvent {
  Id id = Isar.autoIncrement;
  int createAt = DateTime.now().millisecondsSinceEpoch;
  late int age = 0;

  late String role = "";
  late String gameType = "";

  @Index(unique: true)
  late String name;
  late String content;
  late List<SavedEventOption> options = [];

  static SavedEvent fromEvent(Event event) {
    return SavedEvent()
      ..content = event.content
      ..name = event.name
      ..options =
          event.options.map((e) => SavedEventOption.fromOption(e)).toList();
  }
}

@embedded
class SavedEventOption {
  late String content = "";
  late String result = "";

  static SavedEventOption fromOption(Option option) {
    return SavedEventOption()
      ..content = option.content
      ..result = option.result;
  }
}
