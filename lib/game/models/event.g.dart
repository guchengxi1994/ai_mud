// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Event _$EventFromJson(Map<String, dynamic> json) => Event(
      content: json['eventcontent'] as String,
      name: json['eventname'] as String,
      options: (json['eventoptions'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      result: json['result'] as String? ?? "",
    );

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
      'eventcontent': instance.content,
      'eventname': instance.name,
      'eventoptions': instance.options,
      'result': instance.result,
    };
