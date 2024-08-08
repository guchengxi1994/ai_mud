import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NewGameState {
  final String worldType;
  final String worldSetting;
  final String worldOption;
  final String playerRole;
  final String playerName;

  NewGameState(
      {this.worldType = "",
      this.worldOption = "",
      this.playerRole = "",
      this.worldSetting = "",
      this.playerName = "张三"});

  NewGameState copyWith({
    String? worldType,
    String? worldSetting,
    String? worldOption,
    String? playerRole,
    String? playerName,
  }) {
    return NewGameState(
      worldType: worldType ?? this.worldType,
      worldSetting: worldSetting ?? this.worldSetting,
      worldOption: worldOption ?? this.worldOption,
      playerRole: playerRole ?? this.playerRole,
      playerName: playerName ?? this.playerName,
    );
  }
}

class NewGameNotifier extends AutoDisposeNotifier<NewGameState> {
  PageController pageController = PageController();

  final TextEditingController controller = TextEditingController();

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

  void changeWorldOption(String option, List<String> roles) {
    state = state.copyWith(worldOption: "故事发生在$option的环境下,玩家可能的角色包括$roles这几种。");
  }

  void changeWorldRole(String role) {
    state = state.copyWith(playerRole: role);
  }

  void changePlayerName(String name) {
    state = state.copyWith(playerName: name);
  }

  jumpTo(int index) {
    pageController.jumpToPage(index);
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
