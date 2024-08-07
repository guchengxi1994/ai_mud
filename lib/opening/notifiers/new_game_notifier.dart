import 'package:flutter_riverpod/flutter_riverpod.dart';

class NewGameState {
  final String worldType;
  final String worldSetting;
  final String worldOption;
  final String playerRole;

  NewGameState({
    this.worldType = "",
    this.worldOption = "",
    this.playerRole = "",
    this.worldSetting = "",
  });

  NewGameState copyWith({
    String? worldType,
    String? worldSetting,
    String? worldOption,
    String? playerRole,
  }) {
    return NewGameState(
      worldType: worldType ?? this.worldType,
      worldSetting: worldSetting ?? this.worldSetting,
      worldOption: worldOption ?? this.worldOption,
      playerRole: playerRole ?? this.playerRole,
    );
  }
}

class NewGameNotifier extends AutoDisposeNotifier<NewGameState> {
  @override
  NewGameState build() {
    return NewGameState();
  }

  void changeWorldType(String worldType) {
    state = state.copyWith(worldType: worldType);
  }

  void changeWorldSetting(String setting) {
    state = state.copyWith(worldSetting: setting);
  }

  void changeWorldOption(String option) {
    state = state.copyWith(worldOption: "故事发生在$option的环境下");
  }

  bool get valid =>
      state.worldType.isNotEmpty &&
      state.worldSetting.isNotEmpty &&
      state.worldOption.isNotEmpty &&
      state.playerRole.isNotEmpty;
}

final newGameProvider =
    AutoDisposeNotifierProvider<NewGameNotifier, NewGameState>(
        NewGameNotifier.new);
