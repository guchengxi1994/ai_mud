import 'package:ai_mud/game/game_screen.dart';
import 'package:flutter/material.dart';

class GameRouter {
  static const String routeName = "/game";

  static Map<String, WidgetBuilder> get builder {
    return {
      routeName: (context) => const GameScreen(),
    };
  }

  static Future open(BuildContext context) {
    return Navigator.pushNamedAndRemoveUntil(context, routeName, (_) => false);
  }
}
