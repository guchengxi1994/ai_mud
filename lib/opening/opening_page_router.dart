import 'package:ai_mud/opening/opening_page.dart';
import 'package:flutter/material.dart';

class OpengingPageRouter {
  static const String routeName = "/";

  static Map<String, WidgetBuilder> get builder {
    return {
      routeName: (context) => const OpeningPage(),
    };
  }

  static Future open(BuildContext context) {
    return Navigator.pushNamedAndRemoveUntil(context, routeName, (_) => false);
  }
}
