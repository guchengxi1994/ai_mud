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
    );

Map<String, dynamic> _$SystemConfigToJson(SystemConfig instance) =>
    <String, dynamic>{
      'games': instance.games,
      'system-role': instance.systemRole,
    };

Game _$GameFromJson(Map<String, dynamic> json) => Game(
      type: json['type'] as String,
      options:
          (json['options'] as List<dynamic>).map((e) => e as String).toList(),
      roles: (json['roles'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$GameToJson(Game instance) => <String, dynamic>{
      'type': instance.type,
      'options': instance.options,
      'roles': instance.roles,
    };
