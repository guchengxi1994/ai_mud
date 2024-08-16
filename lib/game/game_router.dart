import 'package:ai_mud/game/game_screen.dart';
import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';

class GameRouter {
  static const String routeName = "/game";

  static Map<String, WidgetBuilder> get builder {
    return {
      routeName: (context) =>
          ShowCaseWidget(builder: (c) => const GameScreen()),
    };
  }

  static Future open(BuildContext context) {
    return Navigator.pushNamedAndRemoveUntil(context, routeName, (_) => false);
  }
}
