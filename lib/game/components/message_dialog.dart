import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class MessageDialog extends StatelessWidget {
  const MessageDialog({super.key, required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      elevation: 10,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.8,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: AnimatedTextKit(animatedTexts: [
            ColorizeAnimatedText(
              message,
              textStyle: _colorizeTextStyle,
              colors: _colorizeColors,
            ),
          ]),
        ),
      ),
    );
  }
}

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
