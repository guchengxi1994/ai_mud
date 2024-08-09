import 'package:ai_mud/game/components/period_widget.dart';
import 'package:ai_mud/isar/player.dart';
import 'package:blur/blur.dart';
import 'package:flutter/material.dart';

import 'components/event_board.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/bg2.jpeg"),
                    fit: BoxFit.cover)),
          ).blurred(blur: 5, colorOpacity: 0.1),
          const Positioned(top: 10, right: 10, child: PeriodWidget()),
          Positioned(
              bottom: 50,
              left: MediaQuery.of(context).size.width * (1 - 0.95) / 2,
              child: const EventBoard()),
          const Positioned(top: 90, right: 10, child: PlayerAbilityWidget()),
          Positioned(
              bottom: 0,
              child: SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        /// TODO 这里要做一个设置页面
                      },
                      child: const Icon(
                        Icons.settings,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
