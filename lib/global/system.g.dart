// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'system.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SystemConfig _$SystemConfigFromJson(Map<String, dynamic> json) => SystemConfig(
      games: (json['games'] as List<dynamic>)
          .map((e) => Game.fromJson(e as Map<String, dynamic>))
          .toList(),
      systemRole: (json['system-role'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      common:
          (json['common'] as List<dynamic>).map((e) => e as String).toList(),
      gameSettings:
          GameSettings.fromJson(json['game-settings'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SystemConfigToJson(SystemConfig instance) =>
    <String, dynamic>{
      'games': instance.games,
      'system-role': instance.systemRole,
      'common': instance.common,
      'game-settings': instance.gameSettings,
    };

Game _$GameFromJson(Map<String, dynamic> json) => Game(
      type: json['type'] as String,
      options:
          (json['options'] as List<dynamic>).map((e) => e as String).toList(),
      roles: (json['roles'] as List<dynamic>).map((e) => e as String).toList(),
      aims: (json['aims'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$GameToJson(Game instance) => <String, dynamic>{
      'type': instance.type,
      'options': instance.options,
      'roles': instance.roles,
      'aims': instance.aims,
    };

GameSettings _$GameSettingsFromJson(Map<String, dynamic> json) => GameSettings(
      goodLuck: (json['good-luck'] as num).toDouble(),
      badLuck: (json['bad-luck'] as num).toDouble(),
      goodLuckMessage: json['good-luck-message'] as String,
      badLuckMessage: json['bad-luck-message'] as String,
    );

Map<String, dynamic> _$GameSettingsToJson(GameSettings instance) =>
    <String, dynamic>{
      'good-luck': instance.goodLuck,
      'bad-luck': instance.badLuck,
      'good-luck-message': instance.goodLuckMessage,
      'bad-luck-message': instance.badLuckMessage,
    };
