import 'dart:convert';

import 'package:ai_mud/global/system.dart';
import 'package:ai_mud/isar/database.dart';
import 'package:ai_mud/isar/openai_config_history.dart';
import 'package:isar/isar.dart';
import 'package:langchain_lib/langchain_lib.dart';

import '../common/utils.dart';

class AiClient {
  AiClient._();

  static final _instance = AiClient._();

  factory AiClient() => _instance;

  late SystemConfig systemConfig;

  initOpenAi(String path) {
    OpenaiClient.fromEnv(path);

    Future.microtask(() async {
      final IsarDatabase database = IsarDatabase();

      await database.isar!.writeTxn(() async {
        List<OpenaiConfigHistory> openais = [];

        if (OpenaiClient.models == null) {
          return;
        }

        for (final i in OpenaiClient.models!.models) {
          openais.add(OpenaiConfigHistory()
            ..apiBaseUrl = i.llmBase
            ..apiKey = i.llmSk
            ..model = i.llmModelName
            ..tag = i.tag
            ..temperature = 0.7);
        }

        await database.isar!.openaiConfigHistorys.putAll(openais);
      });
    });
  }

  Future initFromDatabase(IsarDatabase database) async {
    final configs = await database.isar!.openaiConfigHistorys.where().findAll();
    if (configs.isNotEmpty) {
      logger.info("load config from database");
      final Map map = {};
      map["models"] = configs.map((e) => e.toJson()).toList();

      AiClient client = AiClient();
      client.initOpenAiWithString(jsonEncode(map));
    }
  }

  initOpenAiWithString(String s) {
    OpenaiClient.fromString(s);
  }

  Future initSystemConfig(String path) async {
    systemConfig = await SystemConfig.fromAsset(path);
  }

  Stream<ChatResult> stream(List<ChatMessage> history,
      {String tag = "text-model"}) {
    final client = OpenaiClient.getByTag(tag);
    return client!.stream(history);
  }
}
