import 'dart:io';

import 'package:ai_mud/app/app.dart';
import 'package:ai_mud/isar/database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ignore: depend_on_referenced_packages
import 'package:logging/logging.dart';
import 'package:window_manager/window_manager.dart';
import 'common/utils.dart';
import 'global/global.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isLinux) {
    await windowManager.ensureInitialized();

    WindowOptions windowOptions = const WindowOptions(
      size: Size(480, 800),
      maximumSize: Size(480, 800),
      minimumSize: Size(480, 800),
      backgroundColor: Colors.transparent,
      skipTaskbar: false,
    );

    await windowManager.setMaximizable(false);
    await windowManager.setMinimizable(false);

    AudioUtils audioUtils = AudioUtils();
    await audioUtils.setloop();
    await audioUtils.playMainBgm();

    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }

  Logger.root.level = Level.ALL; // defaults to Level.INFO
  Logger.root.onRecord.listen((record) {
    if (kDebugMode) {
      print('${record.level.name}: ${record.time}: ${record.message}');
    }
  });

  IsarDatabase database = IsarDatabase();
  await database.initialDatabase();

  AiClient aiClient = AiClient();
  aiClient.initOpenAi(DevUtils.env);
  aiClient.initSystemConfig(DevUtils.settings);
  runApp(const ProviderScope(child: MyApp()));
}
