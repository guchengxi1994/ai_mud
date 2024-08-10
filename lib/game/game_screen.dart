// ignore_for_file: use_build_context_synchronously

import 'package:ai_mud/game/components/period_widget.dart';
import 'package:ai_mud/global/system_notifier.dart';
import 'package:ai_mud/isar/player.dart';
import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:showcaseview/showcaseview.dart';

import 'components/event_board.dart';

class GameScreen extends ConsumerStatefulWidget {
  const GameScreen({super.key});

  @override
  ConsumerState<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends ConsumerState<GameScreen> {
  final GlobalKey _playerAbilityKey = GlobalKey();
  final GlobalKey<EventBoardState> _eventBoardKey = GlobalKey();
  final GlobalKey _eventKey = GlobalKey();
  final GlobalKey _settingsKey = GlobalKey();
  final GlobalKey _daysKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      bool show = await ref.read(systemProvider.notifier).getHintShown();

      if (!show) {
        ShowCaseWidget.of(context).startShowCase(
            [_daysKey, _playerAbilityKey, _eventKey, _settingsKey]);

        await ref.read(systemProvider.notifier).setHintShown();
      }

      _eventBoardKey.currentState!.plot();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/bg2.jpeg"),
                    fit: BoxFit.cover)),
          ).blurred(blur: 5, colorOpacity: 0.1),
          Positioned(
              top: 10,
              right: 10,
              child: Showcase(
                  key: _daysKey,
                  description: "你已经过了多少时光",
                  child: const PeriodWidget())),
          Positioned(
              bottom: 50,
              left: MediaQuery.of(context).size.width * (1 - 0.95) / 2,
              child: Showcase(
                  key: _eventKey,
                  description: "你可以看看这里，这里是正在进行的事件",
                  child: EventBoard(
                    key: _eventBoardKey,
                  ))),
          Positioned(
              top: 90,
              right: 10,
              child: Showcase(
                  key: _playerAbilityKey,
                  description: "你当前拥有哪些能力",
                  child: const PlayerAbilityWidget())),
          Positioned(
              bottom: 0,
              child: SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    const Spacer(),
                    Showcase(
                        key: _settingsKey,
                        description: "你可以在这里设置一些游戏选项",
                        child: InkWell(
                          onTap: () {
                            /// TODO 这里要做一个设置页面
                          },
                          child: const Icon(
                            Icons.settings,
                            color: Colors.white,
                          ),
                        )),
                    const SizedBox(
                      width: 20,
                    )
                  ],
                ),
              ))
        ],
      )),
    );
  }
}
