import 'package:json_annotation/json_annotation.dart';

part 'event.g.dart';

@JsonSerializable()
class Event {
  @JsonKey(name: "eventcontent")
  final String content;
  @JsonKey(name: "eventname")
  final String name;
  @JsonKey(name: "eventoptions")
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
