import 'package:json_annotation/json_annotation.dart';

part 'event.g.dart';

@JsonSerializable()
class Event {
  final String content;
  final String name;
  final List<String> options;
  String result;

  Event(
      {required this.content,
      required this.name,
      required this.options,
      this.result = ""});

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);

  Map<String, dynamic> toJson() => _$EventToJson(this);
}
