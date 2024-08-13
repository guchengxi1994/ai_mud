import 'dart:async';

import 'package:ai_mud/isar/chat_history.dart';
import 'package:ai_mud/isar/database.dart';
import 'package:ai_mud/isar/openai_config_history.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

import 'settings_state.dart';

class SettingsNotifier extends AutoDisposeAsyncNotifier<SettingsState> {
  final IsarDatabase isarDatabase = IsarDatabase();

  @override
  FutureOr<SettingsState> build() async {
    DateTime now = DateTime.now();

    // 获取今日的开始时间
    DateTime startOfDay = DateTime(now.year, now.month, now.day);
    int startTimestamp = startOfDay.millisecondsSinceEpoch;

    // 获取今日的结束时间
    DateTime endOfDay = DateTime(now.year, now.month, now.day, 23, 59, 59, 999);
    int endTimestamp = endOfDay.millisecondsSinceEpoch;

    final today = await isarDatabase.isar!.chatHistorys
        .filter()
        .createAtBetween(startTimestamp, endTimestamp)
        .findAll();

    final total = await isarDatabase.isar!.chatHistorys.where().findAll();

    final configs =
        await isarDatabase.isar!.openaiConfigHistorys.where().findAll();

    return SettingsState(
      tokenUsedToday: today.map((v) => v.tokenCount).reduce((v, e) => v + e),
      tokenUsedTotal: total.map((v) => v.tokenCount).reduce((v, e) => v + e),
      configs: configs,
    );
  }
}

final settingsProvider =
    AutoDisposeAsyncNotifierProvider<SettingsNotifier, SettingsState>(
        SettingsNotifier.new);
