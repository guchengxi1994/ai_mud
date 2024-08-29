import 'dart:convert';

import 'package:ai_mud/common/dev_utils.dart';
import 'package:flutter/services.dart';
import 'package:json_annotation/json_annotation.dart';

part 'system.g.dart';

@JsonSerializable()
class SystemConfig {
  final List<Game> games;
  @JsonKey(name: "system-role")
  final List<String> systemRole;

  final List<String> common;

  @JsonKey(name: "game-settings")
  final GameSettings gameSettings;

  SystemConfig({
    required this.games,
    required this.systemRole,
    required this.common,
    required this.gameSettings,
  });

  factory SystemConfig.fromJson(Map<String, dynamic> json) =>
      _$SystemConfigFromJson(json);

  Map<String, dynamic> toJson() => _$SystemConfigToJson(this);

  static SystemConfig fromPath(String path) {
    return SystemConfig.fromJson(jsonDecode(DevUtils.readJson(path)));
  }

  static Future<SystemConfig> fromAsset(String s) async {
    final data = await rootBundle.loadString(s);

    return SystemConfig.fromJson(jsonDecode(data));
  }
}

@JsonSerializable()
class Game {
  final String type;
  final List<String> options;
  final List<String> roles;
  final List<String> aims;

  Game(
      {required this.type,
      required this.options,
      required this.roles,
      required this.aims});

  factory Game.fromJson(Map<String, dynamic> json) => _$GameFromJson(json);

  Map<String, dynamic> toJson() => _$GameToJson(this);
}

@JsonSerializable()
class GameSettings {
  @JsonKey(name: "good-luck")
  final double goodLuck;
  @JsonKey(name: "bad-luck")
  final double badLuck;

  @JsonKey(name: "good-luck-message")
  final String goodLuckMessage;

  @JsonKey(name: "bad-luck-message")
  final String badLuckMessage;

  @JsonKey(name: "good-ending")
  final String goodEnding;

  @JsonKey(name: "bad-ending")
  final String badEnding;

  GameSettings(
      {required this.goodLuck,
      required this.badLuck,
      required this.goodLuckMessage,
      required this.badLuckMessage,
      required this.goodEnding,
      required this.badEnding});

  factory GameSettings.fromJson(Map<String, dynamic> json) =>
      _$GameSettingsFromJson(json);

  Map<String, dynamic> toJson() => _$GameSettingsToJson(this);
}
