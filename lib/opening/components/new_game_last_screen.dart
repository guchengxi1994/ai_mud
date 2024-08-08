import 'package:ai_mud/common/app_style.dart';
import 'package:ai_mud/opening/notifiers/new_game_notifier.dart';
import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NewGameLastScreen extends ConsumerWidget {
  const NewGameLastScreen({super.key});

  // 深色背景，奇幻风格，游戏元素，由近及远的景色

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/last.jpeg"),
                  fit: BoxFit.cover)),
        ).blurred(blur: 5, colorOpacity: 0.1),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "开始我们的旅途吧",
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                padding: const EdgeInsets.only(left: 10, right: 10),
                height: 50,
                child: TextField(
                  style: const TextStyle(color: Colors.white),
                  controller: ref.read(newGameProvider.notifier).controller,
                  textAlign: TextAlign.center,
                  decoration: AppStyle.inputDecorationWithHint("输入你的名字,默认为张三"),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
