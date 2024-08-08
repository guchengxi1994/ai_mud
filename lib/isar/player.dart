import 'dart:math';

import 'package:isar/isar.dart';

part 'player.g.dart';

@collection
class Player {
  Id id = Isar.autoIncrement;
  late String name;
  late String role;
  late int maxAge;

  late PlayerAbility ability = PlayerAbility();

  late List<Achievement> achievements = [];
}

@embedded
class PlayerAbility {
  late double /* 持久力 */ endurance = 1;
  late double /* 体力 */ vitality = 1;
  late double /* 记忆力 */ attunement = 1;
  late double /* 力量 */ strength = 1;
  late double /* 敏捷 */ dexterity = 1;
  late double /* 智力 */ intelligence = 1;

  static Random random = Random();

  static PlayerAbility getRandom() {
    return PlayerAbility()
      ..endurance = random.nextInt(10).toDouble() + 1
      ..vitality = random.nextInt(10).toDouble() + 1
      ..attunement = random.nextInt(10).toDouble() + 1
      ..strength = random.nextInt(10).toDouble() + 1
      ..dexterity = random.nextInt(10).toDouble() + 1
      ..intelligence = random.nextInt(10).toDouble() + 1;
  }

  PlayerAbility operator +(Object other) {
    if (other is! PlayerAbility) {
      return this;
    }

    return PlayerAbility()
      ..endurance = endurance + other.endurance
      ..attunement = attunement + other.attunement
      ..strength = strength + other.strength
      ..dexterity = dexterity + other.dexterity
      ..intelligence = intelligence + other.intelligence
      ..vitality = vitality + other.vitality;
  }

  static PlayerAbility fromString(String s) {
    var list = s.split(";");
    PlayerAbility result = PlayerAbility()
      ..attunement = 0
      ..dexterity = 0
      ..endurance = 0
      ..intelligence = 0
      ..strength = 0
      ..vitality = 0;
    if (list.isEmpty) {
      return result;
    }

    for (final i in list) {
      final s = i.split("_");
      if (s.length != 2) {
        continue;
      }
      final name = s[0];
      final value = double.tryParse(s[1]) ?? 0;
      switch (name) {
        case "endurance":
          result.endurance = value;
          break;
        case "vitality":
          result.vitality = value;
          break;
        case "attunement":
          result.attunement = value;
          break;
        case "strength":
          result.strength = value;
          break;
        case "dexterity":
          result.dexterity = value;
          break;
        case "intelligence":
          result.intelligence = value;
          break;
      }
    }

    return result;
  }
}

@embedded
class Achievement {
  late String name;
  String? iconPath;
  late String description;
  int createAt = DateTime.now().millisecondsSinceEpoch;

  @override
  bool operator ==(Object other) {
    if (other is! Achievement) {
      return false;
    }
    return name == other.name;
  }

  @override
  int get hashCode => name.hashCode;
}
