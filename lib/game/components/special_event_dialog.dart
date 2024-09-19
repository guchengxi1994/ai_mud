import 'package:flutter/material.dart';

class SpecialEventDialog extends StatefulWidget {
  const SpecialEventDialog(
      {super.key, required this.satisfied, required this.eventName});
  final bool satisfied;
  final String eventName;

  @override
  State<SpecialEventDialog> createState() => _SpecialEventDialogState();
}

class _SpecialEventDialogState extends State<SpecialEventDialog> {
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
        child: Center(
          child: widget.satisfied
              ? Column(
                  children: [
                    const Text(
                      "😃",
                      style: TextStyle(fontSize: 100),
                    ),
                    Text("恭喜你，你触发了一个特殊事件！${widget.eventName}")
                  ],
                )
              : Column(
                  children: [
                    const Text(
                      "😨",
                      style: TextStyle(fontSize: 100),
                    ),
                    Text("你触发了一个特殊事件${widget.eventName}，但是你无法达到要求")
                  ],
                ),
        ),
      ),
    );
  }
}
