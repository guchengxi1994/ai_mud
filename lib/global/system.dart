import 'dart:convert';

import 'package:ai_mud/common/dev_utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'system.g.dart';

@JsonSerializable()
class SystemConfig {
  final List<Game> games;
  @JsonKey(name: "system-role")
  final List<String> systemRole;

  SystemConfig({required this.games, required this.systemRole});

  factory SystemConfig.fromJson(Map<String, dynamic> json) =>
      _$SystemConfigFromJson(json);

  Map<String, dynamic> toJson() => _$SystemConfigToJson(this);

  static SystemConfig fromPath(String path) {
    return SystemConfig.fromJson(jsonDecode(DevUtils.readJson(path)));
  }
}

@JsonSerializable()
class Game {
  final String type;
  final List<String> options;

  Game({required this.type, required this.options});

  factory Game.fromJson(Map<String, dynamic> json) => _$GameFromJson(json);

  Map<String, dynamic> toJson() => _$GameToJson(this);
}