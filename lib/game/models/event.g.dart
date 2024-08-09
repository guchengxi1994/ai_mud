// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Event _$EventFromJson(Map<String, dynamic> json) => Event(
      content: json['content'] as String,
      name: json['name'] as String,
      options:
          (json['options'] as List<dynamic>).map((e) => e as String).toList(),
      result: json['result'] as String? ?? "",
    );

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
      'content': instance.content,
      'name': instance.name,
      'options': instance.options,
      'result': instance.result,
    };
