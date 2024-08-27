import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

typedef OnTap = void Function(Object? o);

class ActiveButton extends StatefulWidget {
  const ActiveButton({
    super.key,
    required this.onTap,
    required this.debugLabel,
    required this.content,
    this.activeColor = Colors.blue,
    this.inactiveColor = Colors.grey,
    this.enable = true,
  });
  final OnTap onTap;
  final int debugLabel;
  final String content;
  final Color? activeColor;
  final Color? inactiveColor;
  final bool enable;

  @override
  State<ActiveButton> createState() => _ActiveButtonState();
}

class _ActiveButtonState extends State<ActiveButton> {
  bool active = false;

  final double height = 50;
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid || Platform.isIOS) {
      return InkWell(
        onTap: widget.enable ? () => widget.onTap(widget.content) : null,
        child: Container(
          height: height,
          width: MediaQuery.of(context).size.width * 0.8,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: active ? widget.activeColor : widget.inactiveColor),
          margin: const EdgeInsets.only(top: 10),
          child: Center(
            child: Text(
              widget.content,
              style: TextStyle(
                  color: active ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: widget.enable ? () => widget.onTap(widget.content) : null,
      child: MouseRegion(
        onEnter: (event) {
          _audioPlayer.play(AssetSource("audios/y1970.wav"), volume: 1);

          setState(() {
            active = true;
          });
        },
        onExit: (event) => setState(() {
          active = false;
        }),
        cursor:
            widget.enable ? SystemMouseCursors.click : SystemMouseCursors.basic,
        child: Container(
          height: height,
          width: MediaQuery.of(context).size.width * 0.8,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: active ? widget.activeColor : widget.inactiveColor),
          margin: const EdgeInsets.only(top: 10),
          child: Center(
            child: Text(
              widget.content,
              style: TextStyle(
                  color: active ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
