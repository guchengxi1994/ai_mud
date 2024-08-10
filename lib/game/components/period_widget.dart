import 'package:ai_mud/global/system_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PeriodWidget extends ConsumerStatefulWidget {
  const PeriodWidget({super.key});

  @override
  ConsumerState<PeriodWidget> createState() => PeriodWidgetState();
}

class PeriodWidgetState extends ConsumerState<PeriodWidget>
    with TickerProviderStateMixin {
  // late int dayNumber = 1;
  late AnimationController _yearController;
  late AnimationController _monthController;
  late AnimationController _tenDayPeriodController;
  late Animation<double> _yearAnimation;
  late Animation<double> _monthAnimation;
  late Animation<double> _tenDayPeriodAnimation;

  late ValueNotifier<String> _yearNotifier;
  late ValueNotifier<String> _monthNotifier;
  late ValueNotifier<String> _tenDayPeriodNotifier;

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
    _yearNotifier = ValueNotifier<String>("1");
    _monthNotifier = ValueNotifier<String>("1");
    _tenDayPeriodNotifier = ValueNotifier<String>("上旬");
  }

  calculateYearMonthTenDay(int dayNumber) {
    const int daysInYear = 36;
    const int daysInMonth = 3;

    int year = (dayNumber - 1) ~/ daysInYear + 1;
    int dayOfYear = (dayNumber - 1) % daysInYear + 1;
    int month = (dayOfYear - 1) ~/ daysInMonth + 1;
    int dayOfMonth = (dayOfYear - 1) % daysInMonth + 1;

    String tenDayPeriod;
    if (dayOfMonth == 1) {
      tenDayPeriod = '上旬';
    } else if (dayOfMonth == 2) {
      tenDayPeriod = '中旬';
    } else {
      tenDayPeriod = '下旬';
    }

    if (_yearNotifier.value != year.toString()) {
      _yearNotifier.value = year.toString();
      _yearController.forward(from: 0);
    }

    if (_monthNotifier.value != month.toString()) {
      _monthNotifier.value = month.toString();
      _monthController.forward(from: 0);
    }

    _tenDayPeriodNotifier.value = tenDayPeriod;
    _tenDayPeriodController.forward(from: 0);
  }

  @override
  void dispose() {
    _yearController.dispose();
    _monthController.dispose();
    _tenDayPeriodController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(systemProvider.select((p) => p.historyLength));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      calculateYearMonthTenDay(state);
    });

    return Material(
      borderRadius: BorderRadius.circular(10),
      elevation: 10,
      child: Container(
        width: 200,
        height: 50,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ValueListenableBuilder(
                valueListenable: _yearNotifier,
                builder: (c, v, _) {
                  return AnimatedBuilder(
                      animation: _yearAnimation,
                      builder: (ctx, c) {
                        return Opacity(
                            opacity: _yearAnimation.value > 0
                                ? _yearAnimation.value
                                : 1.0,
                            child: Text(v));
                      });
                }),
            const Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Text("年"),
            ),
            ValueListenableBuilder(
                valueListenable: _monthNotifier,
                builder: (c, v, _) {
                  return AnimatedBuilder(
                      animation: _monthAnimation,
                      builder: (ctx, c) {
                        return Opacity(
                            opacity: _monthAnimation.value > 0
                                ? _monthAnimation.value
                                : 1.0,
                            child: Text(v));
                      });
                }),
            const Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Text("月"),
            ),
            ValueListenableBuilder(
                valueListenable: _tenDayPeriodNotifier,
                builder: (c, v, _) {
                  return AnimatedBuilder(
                      animation: _tenDayPeriodAnimation,
                      builder: (ctx, c) {
                        return Opacity(
                            opacity: _tenDayPeriodAnimation.value > 0
                                ? _tenDayPeriodAnimation.value
                                : 1.0,
                            child: Text(v));
                      });
                }),
          ],
        ),
      ),
    );
  }
}
