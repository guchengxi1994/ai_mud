import 'package:ai_mud/isar/openai_config_history.dart';

class SettingsState {
  final int tokenUsedTotal;
  final int tokenUsedToday;
  final List<OpenaiConfigHistory> configs;

  SettingsState({
    this.tokenUsedTotal = 0,
    this.tokenUsedToday = 0,
    this.configs = const [],
  });

  SettingsState copyWith({
    int? tokenUsedTotal,
    int? tokenUsedToday,
    List<OpenaiConfigHistory>? configs,
  }) {
    return SettingsState(
      tokenUsedTotal: tokenUsedTotal ?? this.tokenUsedTotal,
      tokenUsedToday: tokenUsedToday ?? this.tokenUsedToday,
      configs: configs ?? this.configs,
    );
  }
}
