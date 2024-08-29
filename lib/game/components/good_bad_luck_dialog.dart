import 'package:ai_mud/common/app_style.dart';
import 'package:ai_mud/global/ai_client.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:blur/blur.dart';
import 'package:flutter/material.dart';

class GoodBadLuckDialog extends StatefulWidget {
  const GoodBadLuckDialog({super.key, required this.isGoodLuck});
  final bool isGoodLuck;

  @override
  State<GoodBadLuckDialog> createState() => _GoodBadLuckDialogState();
}

class _GoodBadLuckDialogState extends State<GoodBadLuckDialog> {
  final settings = AiClient().systemConfig.gameSettings;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      elevation: 10,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: AssetImage(widget.isGoodLuck
                          ? "assets/images/succeed.jpeg"
                          : "assets/images/fail.jpeg"),
                      fit: BoxFit.cover)),
            ).blurred(
              blur: 5,
              colorOpacity: 0.1,
              borderRadius: BorderRadius.circular(10),
            ),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedTextKit(animatedTexts: [
                    ColorizeAnimatedText(
                      widget.isGoodLuck
                          ? settings.goodLuckMessage
                          : settings.badLuckMessage,
                      textStyle: AppStyle.colorizeTextStyle,
                      colors: AppStyle.colorizeColors,
                    ),
                  ]),
                  Text(
                    widget.isGoodLuck ? "恭喜你，你获得了5年寿命" : "你损失了5年寿命",
                    style: const TextStyle(
                        fontFamily: "xing", color: Colors.white, fontSize: 30),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
