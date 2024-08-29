import 'dart:io';

import 'package:ai_mud/app/app.dart';
import 'package:ai_mud/isar/database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langchain_lib/langchain_lib.dart';

// ignore: depend_on_referenced_packages
import 'package:logging/logging.dart';
import 'package:window_manager/window_manager.dart';
import 'common/utils.dart';
import 'global/global.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Logger.root.level = Level.ALL; // defaults to Level.INFO
  Logger.root.onRecord.listen((record) {
    if (kDebugMode) {
      print('${record.level.name}: ${record.time}: ${record.message}');
    }
  });
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

    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }

  AudioUtils audioUtils = AudioUtils();
  await audioUtils.setloop();
  await audioUtils.playMainBgm();

  AiClient aiClient = AiClient();
  IsarDatabase database = IsarDatabase();
  await database.initialDatabase();
  await aiClient.initFromDatabase(database);

  if (OpenaiClient.models == null) {
    logger.info("load config from env");
    aiClient.initOpenAi(DevUtils.env);
  }

  await aiClient.initSystemConfig(DevUtils.settings);
  await aiClient.initSplash(DevUtils.splash);

  runApp(const ProviderScope(child: MyApp()));
}
