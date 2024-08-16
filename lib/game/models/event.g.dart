// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Event _$EventFromJson(Map<String, dynamic> json) => Event(
      content: json['eventcontent'] as String,
      name: json['eventname'] as String,
      options: (json['eventoptions'] as List<dynamic>)
          .map((e) => Option.fromJson(e as Map<String, dynamic>))
          .toList(),
      result: json['result'] as String? ?? "",
    );

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
      'eventcontent': instance.content,
      'eventname': instance.name,
      'eventoptions': instance.options,
      'result': instance.result,
    };

Option _$OptionFromJson(Map<String, dynamic> json) => Option(
      content: json['content'] as String,
      result: json['result'] as String,
    );

Map<String, dynamic> _$OptionToJson(Option instance) => <String, dynamic>{
      'content': instance.content,
      'result': instance.result,
    };
