// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Time Period App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TimePeriodScreen(),
    );
  }
}

class TimePeriodScreen extends StatefulWidget {
  const TimePeriodScreen({super.key});

  @override
  _TimePeriodScreenState createState() => _TimePeriodScreenState();
}

class _TimePeriodScreenState extends State<TimePeriodScreen>
    with TickerProviderStateMixin {
  int dayNumber = 1;
  late AnimationController _yearController;
  late AnimationController _monthController;
  late AnimationController _tenDayPeriodController;
  late Animation<double> _yearAnimation;
  late Animation<double> _monthAnimation;
  late Animation<double> _tenDayPeriodAnimation;

  @override
  void initState() {
    super.initState();
    _yearController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _monthController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _tenDayPeriodController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _yearAnimation = CurvedAnimation(
      parent: _yearController,
      curve: Curves.easeInOut,
    );
    _monthAnimation = CurvedAnimation(
      parent: _monthController,
      curve: Curves.easeInOut,
    );
    _tenDayPeriodAnimation = CurvedAnimation(
      parent: _tenDayPeriodController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _yearController.dispose();
    _monthController.dispose();
    _tenDayPeriodController.dispose();
    super.dispose();
  }

  void _updateDayNumber(int newDayNumber) {
    setState(() {
      dayNumber = newDayNumber;
    });
    _yearController.forward(from: 0);
    _monthController.forward(from: 0);
    _tenDayPeriodController.forward(from: 0);
  }

  List<String> calculateYearMonthTenDay(int dayNumber) {
    const int daysInYear = 360;
    const int daysInMonth = 30;

    int year = (dayNumber - 1) ~/ daysInYear + 1;
    int dayOfYear = (dayNumber - 1) % daysInYear + 1;
    int month = (dayOfYear - 1) ~/ daysInMonth + 1;
    int dayOfMonth = (dayOfYear - 1) % daysInMonth + 1;

    String tenDayPeriod;
    if (dayOfMonth <= 10) {
      tenDayPeriod = '上旬';
    } else if (dayOfMonth <= 20) {
      tenDayPeriod = '中旬';
    } else {
      tenDayPeriod = '下旬';
    }

    return ['Year $year', 'Month $month', 'Ten-Day Period $tenDayPeriod'];
  }

  @override
  Widget build(BuildContext context) {
    List<String> period = calculateYearMonthTenDay(dayNumber);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Time Period App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AnimatedBuilder(
              animation: _yearAnimation,
              builder: (context, child) {
                return Opacity(
                  opacity: _yearAnimation.value,
                  child: Text(
                    period[0],
                    style: const TextStyle(fontSize: 24),
                  ),
                );
              },
            ),
            AnimatedBuilder(
              animation: _monthAnimation,
              builder: (context, child) {
                return Opacity(
                  opacity: _monthAnimation.value,
                  child: Text(
                    period[1],
                    style: const TextStyle(fontSize: 24),
                  ),
                );
              },
            ),
            AnimatedBuilder(
              animation: _tenDayPeriodAnimation,
              builder: (context, child) {
                return Opacity(
                  opacity: _tenDayPeriodAnimation.value,
                  child: Text(
                    period[2],
                    style: const TextStyle(fontSize: 24),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _updateDayNumber(dayNumber + 10);
              },
              child: const Text('Next Day'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                _updateDayNumber(dayNumber - 10);
              },
              child: const Text('Previous Day'),
            ),
          ],
        ),
      ),
    );
  }
}
