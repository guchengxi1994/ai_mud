import 'package:ai_mud/splash/splash_screen.dart';
import 'package:flutter/material.dart';

class SplashScreenRouter {
  static const String routeName = "/";

  static Map<String, WidgetBuilder> get builder {
    return {
      routeName: (context) => const SplashScreen(),
    };
  }

  static Future open(BuildContext context) {
    return Navigator.pushNamedAndRemoveUntil(context, routeName, (_) => false);
  }
}
