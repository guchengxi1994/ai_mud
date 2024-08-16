import 'package:ai_mud/game/game_router.dart';
import 'package:ai_mud/opening/opening_page_router.dart';
import 'package:ai_mud/settings/settings_screen_router.dart';
import 'package:flutter/material.dart';

class AppRouters {
  static Map<String, WidgetBuilder> get routes => {
        ...OpengingPageRouter.builder,
        ...GameRouter.builder,
        ...SettingsPageRouter.builder
      };
}
