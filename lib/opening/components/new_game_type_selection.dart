import 'package:ai_mud/global/global.dart';
import 'package:ai_mud/opening/components/active_button.dart';
import 'package:ai_mud/opening/components/world_setting.dart';
import 'package:ai_mud/opening/notifiers/new_game_notifier.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NewGameTypeSelection extends ConsumerStatefulWidget {
  const NewGameTypeSelection({super.key});

  @override
  ConsumerState<NewGameTypeSelection> createState() =>
      _NewGameTypeSelectionState();
}

class _NewGameTypeSelectionState extends ConsumerState<NewGameTypeSelection> {
  static SystemConfig config = AiClient().systemConfig;

  bool shouldShow = true;
  bool hasAnimated = false;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(newGameProvider);
    return Stack(
      children: [
        SizedBox.expand(
          child: Column(
            children: [
              SizedBox(
                height: 50,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: shouldShow
                      ? const Text("请选择游戏类型")
                      : Text("已选择${state.worldType}"),
                ),
              ),
              AnimatedOpacity(
                  duration: const Duration(milliseconds: 500),
                  opacity: shouldShow ? 1.0 : 0,
                  child: Column(
                    children: config.games
                        .mapIndexed((i, v) => ActiveButton(
                            enable: shouldShow,
                            inactiveColor: Colors.grey[300],
                            onTap: (s) {
                              ref
                                  .read(newGameProvider.notifier)
                                  .changeWorldType("");
                              ref
                                  .read(newGameProvider.notifier)
                                  .changeWorldType(v.type);
                            },
                            debugLabel: i,
                            content: v.type))
                        .toList(),
                  ))
            ],
          ),
        ),
        // if (state.worldType != "")

        AnimatedPositioned(
          height: 70,
          width: MediaQuery.of(context).size.width * 0.8,
          // top: state.worldType != "" ? 0 : null,
          left: MediaQuery.of(context).size.width * 0.1,
          bottom: state.worldType == ""
              ? -100
              : MediaQuery.of(context).size.height - 120 - 50,
          curve: Curves.easeInOut,
          onEnd: () {
            setState(() {
              shouldShow = !shouldShow;
            });
          },
          duration: const Duration(milliseconds: 500),
          child: ActiveButton(
            debugLabel: 0,
            content: state.worldType,
            onTap: (s) {
              ref.read(newGameProvider.notifier).changeWorldType("");
            },
          ),
        ),
        _getWorldSetting(state)
      ],
    );
  }

  Widget _getWorldSetting(NewGameState state) {
    return Positioned(
        top: 150,
        child: Visibility(
            visible: !shouldShow,
            child: Container(
              alignment: Alignment.topCenter,
              height: MediaQuery.of(context).size.height * 0.6,
              width: MediaQuery.of(context).size.width,
              child: state.worldType == ""
                  ? Container()
                  : SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 50,
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: !shouldShow
                                  ? const Text("请选择场景")
                                  : Text("已选择${state.worldOption}"),
                            ),
                          ),
                          Expanded(
                              child: ListView.builder(
                                  itemCount: config.games
                                      .where((v) => v.type == state.worldType)
                                      .first
                                      .options
                                      .length,
                                  itemBuilder: (c, i) {
                                    return ActiveButton(
                                        inactiveColor: Colors.grey[300],
                                        onTap: (s) {
                                          final game = config.games
                                              .where((v) =>
                                                  v.type == state.worldType)
                                              .first;
                                          ref
                                              .read(newGameProvider.notifier)
                                              .changeWorldOption(
                                                  game.options[i], game.roles);

                                          showGeneralDialog(
                                              barrierLabel: "world-setting",
                                              barrierDismissible: false,
                                              barrierColor: Colors.transparent,
                                              context: context,
                                              pageBuilder: (c, _, __) {
                                                return Center(
                                                  child: WorldSettingWidget(
                                                    type: ref
                                                        .read(newGameProvider)
                                                        .worldType,
                                                    details: ref
                                                        .read(newGameProvider)
                                                        .worldOption,
                                                  ),
                                                );
                                              }).then((v) {
                                            // print(v);
                                            if (v != null) {
                                              ref
                                                  .read(
                                                      newGameProvider.notifier)
                                                  .changeWorldSetting(
                                                      v.toString());

                                              ref
                                                  .read(
                                                      newGameProvider.notifier)
                                                  .jumpTo(1);
                                            }
                                          });
                                        },
                                        debugLabel: i,
                                        content: config.games
                                            .where((v) =>
                                                v.type == state.worldType)
                                            .first
                                            .options[i]);
                                  }))
                        ],
                      ),
                    ),
            )));
  }
}
