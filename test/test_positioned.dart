import 'package:flutter/material.dart';

class AllAlongDemo extends StatefulWidget {
  const AllAlongDemo({super.key});

  @override
  State<AllAlongDemo> createState() => _AllAlongDemoState();
}

class _AllAlongDemoState extends State<AllAlongDemo> {
  bool isGreenVisible = true;

  void toggleWidgets() {
    setState(() {
      isGreenVisible = !isGreenVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: toggleWidgets,
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 500),
              top: isGreenVisible ? 0 : -60,
              child: Container(
                width: 100,
                height: 100,
                color: Colors.green,
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 500),
              top: isGreenVisible ? 60 : 0,
              child: Container(
                width: 100,
                height: 100,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: AllAlongDemo(),
  ));
}
