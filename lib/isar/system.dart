import 'package:isar/isar.dart';

import 'player.dart';

part 'system.g.dart';

@collection
class System {
  Id id = Isar.autoIncrement;
  int createAt = DateTime.now().millisecondsSinceEpoch;

  late String type;

  bool hintShown = false;

  /// 世界观
  late String worldSetting;
  late List<String> details = [];

  late List<History> history = [];

  IsarLink<Player> player = IsarLink<Player>();

  String _prompt() {
    StringBuffer sb = StringBuffer();
    sb.writeln("这是一款$type类型的游戏。");

    if (details.isNotEmpty) {
      sb.writeln("具体信息如下：");
    }

    for (final s in details) {
      sb.writeln(s);
    }

    return sb.toString();
  }

  String get prompt => _prompt();
}

@embedded
class History {
  int createAt = DateTime.now().millisecondsSinceEpoch;
  late String content;
  late String name;
  late List<String> options;
  late String result;
}
