import 'package:ai_mud/global/system_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langchain_lib/langchain_lib.dart';

class WorldSettingWidget extends ConsumerStatefulWidget {
  const WorldSettingWidget({super.key, required this.type});
  final String type;

  @override
  ConsumerState<WorldSettingWidget> createState() => _WorldSettingWidgetState();
}

class _WorldSettingWidgetState extends ConsumerState<WorldSettingWidget> {
  late final Stream<ChatResult> stream;

  @override
  void initState() {
    super.initState();
    stream = ref.read(systemProvider.notifier).generateWorld(widget.type);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.white),
      ),
    );
  }
}
