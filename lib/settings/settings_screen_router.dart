import 'package:ai_mud/settings/settings_screen.dart';
import 'package:flutter/material.dart';

class SettingsPageRouter {
  static const String routeName = "/settings";

  static Map<String, WidgetBuilder> get builder {
    return {
      routeName: (context) => const SettingsScreen(),
    };
  }

  static Future open(BuildContext context) {
    return Navigator.pushNamed(context, routeName);
  }
}
