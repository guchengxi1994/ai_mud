import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:json_annotation/json_annotation.dart';

part 'splash_model.g.dart';

@JsonSerializable()
class SplashModel {
  @JsonKey(name: "to-whom")
  final String toWhom;
  final String wish;

  static Future<SplashModel> fromAsset(String s) async {
    final data = await rootBundle.loadString(s);

    return SplashModel.fromJson(jsonDecode(data));
  }

  SplashModel({
    required this.toWhom,
    required this.wish,
  });

  factory SplashModel.fromJson(Map<String, dynamic> json) =>
      _$SplashModelFromJson(json);

  Map<String, dynamic> toJson() => _$SplashModelToJson(this);
}
