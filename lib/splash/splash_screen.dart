import 'dart:async';

import 'package:ai_mud/global/ai_client.dart';
import 'package:ai_mud/opening/opening_page_router.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

const _colorizeColors = [
  Colors.purple,
  Colors.blue,
  Colors.yellow,
  Colors.red,
];

const _colorizeTextStyle = TextStyle(
  fontSize: 50.0,
  fontFamily: 'xing',
);

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final splashConfig = AiClient().splashModel;

  @override
  void initState() {
    super.initState();
    // 设置5秒的定时器，时间结束后跳转到主界面
    Timer(const Duration(seconds: 5), () {
      OpengingPageRouter.open(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          OpengingPageRouter.open(context);
        },
        child: Stack(
          children: [
            SizedBox.expand(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: AnimatedTextKit(
                      animatedTexts: [
                        ColorizeAnimatedText(
                          '谨以此游戏',
                          textStyle: _colorizeTextStyle,
                          colors: _colorizeColors,
                        ),
                      ],
                      isRepeatingAnimation: true,
                    ),
                  ),
                  AnimatedTextKit(
                    animatedTexts: [
                      ColorizeAnimatedText(
                        '祝：${splashConfig.toWhom}',
                        textStyle: _colorizeTextStyle,
                        colors: _colorizeColors,
                      ),
                    ],
                    isRepeatingAnimation: true,
                  ),
                  AnimatedTextKit(
                    animatedTexts: [
                      ColorizeAnimatedText(
                        splashConfig.wish,
                        textStyle: _colorizeTextStyle,
                        colors: _colorizeColors,
                      ),
                    ],
                    isRepeatingAnimation: true,
                  )
                ],
              ),
            ),
            const Positioned(
                left: 10,
                bottom: 10,
                child: AutoSizeText(
                  "A game powered by AI, created by xiaoshuyui",
                  maxLines: 1,
                  style: TextStyle(fontFamily: 'xing', fontSize: 25),
                ))
          ],
        ),
      ),
    );
  }
}
