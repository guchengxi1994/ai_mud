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
          const Positioned(top: 90, right: 10, child: PlayerAbilityWidget()),
          Positioned(
              bottom: 50,
              left: MediaQuery.of(context).size.width * (1 - 0.95) / 2,
              child: const EventBoard()),
        ],
      ),
    );
  }
}
