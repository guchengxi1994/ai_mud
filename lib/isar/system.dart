import 'package:isar/isar.dart';

part 'system.g.dart';

@collection
class System {
  Id id = Isar.autoIncrement;

  late String type;

  /// 世界观
  late String worldSetting;
  late List<String> details;

  late List<History> history = [];

  /// 减少prompt token使用量
  late String historySummary = "";

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

enum HistoryType { player, ai }

@embedded
class History {
  int createAt = DateTime.now().millisecondsSinceEpoch;
  late String content;

  @enumerated
  late HistoryType type;
}
