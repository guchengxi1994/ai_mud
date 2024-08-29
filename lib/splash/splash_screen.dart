import 'dart:async';

import 'package:ai_mud/common/app_style.dart';
import 'package:ai_mud/global/ai_client.dart';
import 'package:ai_mud/opening/opening_page_router.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final splashConfig = AiClient().splashModel;

  // ignore: unused_field
  late Timer? _timer;

  @override
  void initState() {
    super.initState();
    // 设置5秒的定时器，时间结束后跳转到主界面
    _timer = Timer(const Duration(seconds: 5), () {
      OpengingPageRouter.open(context);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          OpengingPageRouter.open(context);
        },
        // ignore: avoid_unnecessary_containers
        child: Container(
          color: Colors.white,
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
                            textStyle: AppStyle.colorizeTextStyle,
                            colors: AppStyle.colorizeColors,
                          ),
                        ],
                        isRepeatingAnimation: true,
                      ),
                    ),
                    AnimatedTextKit(
                      animatedTexts: [
                        ColorizeAnimatedText(
                          '祝：${splashConfig.toWhom}',
                          textStyle: AppStyle.colorizeTextStyle,
                          colors: AppStyle.colorizeColors,
                        ),
                      ],
                      isRepeatingAnimation: true,
                    ),
                    AnimatedTextKit(
                      animatedTexts: [
                        ColorizeAnimatedText(
                          splashConfig.wish,
                          textStyle: AppStyle.colorizeTextStyle,
                          colors: AppStyle.colorizeColors,
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
      ),
    );
  }
}
