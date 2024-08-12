import 'dart:convert';

import 'package:ai_mud/common/dev_utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'system.g.dart';

@JsonSerializable()
class SystemConfig {
  final List<Game> games;
  @JsonKey(name: "system-role")
  final List<String> systemRole;

  final List<String> common;

  SystemConfig(
      {required this.games, required this.systemRole, required this.common});

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
  final List<String> roles;

  Game({required this.type, required this.options, required this.roles});

  factory Game.fromJson(Map<String, dynamic> json) => _$GameFromJson(json);

  Map<String, dynamic> toJson() => _$GameToJson(this);
}
