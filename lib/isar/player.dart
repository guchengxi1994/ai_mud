import 'dart:math';

import 'package:ai_mud/global/system_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_radar_chart/flutter_radar_chart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';

part 'player.g.dart';

RegExp regex = RegExp(r'(\w+)([<>=]+)(-?\d+)');

@collection
class Player {
  Id id = Isar.autoIncrement;
  late String name;
  late String role;
  late int maxAge;
  late String? aim = "活着";

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

  String operator [](int index) {
    switch (index) {
      case 0:
        return "End";
      case 1:
        return "Vit";
      case 2:
        return "Att";
      case 3:
        return "Str";
      case 4:
        return "Dex";
      case 5:
        return "Int";
      default:
        return "";
    }
  }

  @override
  String toString() {
    return "End_${endurance.toStringAsFixed(2)};Vit_${vitality.toStringAsFixed(2)};Att_${attunement.toStringAsFixed(2)};Str_${strength.toStringAsFixed(2)};Dex_${dexterity.toStringAsFixed(2)};Int_${intelligence.toStringAsFixed(2)}";
  }

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
        case "End":
          result.endurance = value;
          break;
        case "Vit":
          result.vitality = value;
          break;
        case "Att":
          result.attunement = value;
          break;
        case "Str":
          result.strength = value;
          break;
        case "Dex":
          result.dexterity = value;
          break;
        case "Int":
          result.intelligence = value;
          break;
      }
    }

    return result;
  }

  bool satisfied(String s) {
    if (s.trim().isEmpty) {
      return true;
    }

    bool result = true;
    List<String> expressions = s.split(';');
    for (final i in expressions) {
      var match = regex.firstMatch(i);
      if (match == null) {
        continue;
      }

      String variable = match.group(1)!;
      String operator = match.group(2)!;
      int value = int.parse(match.group(3)!);

      switch (variable) {
        case "End":
          switch (operator) {
            case ">=":
              result = endurance >= value;
              break;
            case "<=":
              result = endurance <= value;
              break;
            case "==":
              result = endurance == value;
              break;
            case '<':
              result = endurance < value;
              break;
            case '>':
              result = endurance > value;
              break;
            default:
              break;
          }
        case "Vit":
          switch (operator) {
            case ">=":
              result = vitality >= value;
              break;
            case "<=":
              result = vitality <= value;
              break;
            case "==":
              result = vitality == value;
              break;
            case '<':
              result = vitality < value;
              break;
            case '>':
              result = vitality > value;
          }
        case "Att":
          switch (operator) {
            case ">=":
              result = attunement >= value;
              break;
            case "<=":
              result = attunement <= value;
              break;
            case "==":
              result = attunement == value;
              break;
            case '<':
              result = attunement < value;
              break;
            case '>':
              result = attunement > value;
              break;
            default:
              break;
          }
        case "Str":
          switch (operator) {
            case ">=":
              result = strength >= value;
              break;
            case "<=":
              result = strength <= value;
              break;
            case "==":
              result = strength == value;
              break;
            case '<':
              result = strength < value;
              break;
            case '>':
              result = strength > value;
              break;
            default:
              break;
          }
        case "Dex":
          switch (operator) {
            case ">=":
              result = dexterity >= value;
              break;
            case "<=":
              result = dexterity <= value;
              break;
            case "==":
              result = dexterity == value;
              break;
            case '<':
              result = dexterity < value;
              break;
            case '>':
              result = dexterity > value;
              break;
            default:
              break;
          }
        case "Int":
          switch (operator) {
            case ">=":
              result = intelligence >= value;
              break;
            case "<=":
              result = intelligence <= value;
              break;
            case "==":
              result = intelligence == value;
              break;
            case '<':
              result = intelligence < value;
              break;
            case '>':
              result = intelligence > value;
              break;
            default:
              break;
          }
        default:
          break;
      }
    }

    return result;
  }
}

const ticks = [20, 40, 60, 80, 100];

const features = ["End", "Vit", "Att", "Str", "Dex", "Int"];

class PlayerAbilityWidget extends ConsumerStatefulWidget {
  const PlayerAbilityWidget({super.key});

  @override
  ConsumerState<PlayerAbilityWidget> createState() =>
      _PlayerAbilityWidgetState();
}

class _PlayerAbilityWidgetState extends ConsumerState<PlayerAbilityWidget> {
  double _width = 30;
  double _height = 30;

  bool isExpanded = false;

  late PlayerAbility ability;

  late List<double> data = [
    ability.endurance,
    ability.vitality,
    ability.attunement,
    ability.strength,
    ability.dexterity,
    ability.intelligence,
  ];

  loadAbility() {
    ability = ref.read(systemProvider.notifier).getAbilitySync();
    data = [
      ability.endurance,
      ability.vitality,
      ability.attunement,
      ability.strength,
      ability.dexterity,
      ability.intelligence,
    ];
  }

  void _changeSize() {
    setState(() {
      _width = _width == 30 ? 350 : 30;
      _height = _height == 30 ? 200 : 30;
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    loadAbility();
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: _changeSize,
        child: AnimatedContainer(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(isExpanded ? 10 : 4),
            color: Colors.white,
          ),
          width: _width,
          height: _height,
          duration: const Duration(seconds: 1),
          curve: Curves.easeInOut,
          child: Center(
            child: isExpanded
                ? Material(
                    borderRadius: BorderRadius.circular(10),
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: SingleChildScrollView(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 200,
                                height: 180,
                                child: RadarChart.light(
                                    ticks: ticks,
                                    features: features,
                                    data: [data]),
                              ),
                              const SizedBox(
                                width: 60,
                              ),
                              SizedBox(
                                  width: 350 - 200 - 60,
                                  height: 180,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: data
                                        .mapIndexed((i, e) =>
                                            Text("${ability[i]} : $e"))
                                        .toList(),
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                : const Material(
                    elevation: 4,
                    child: Icon(Icons.add_chart),
                  ),
          ),
        ),
      ),
    );
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
