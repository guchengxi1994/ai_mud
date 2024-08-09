import 'package:ai_mud/game/notifiers/game_notifier.dart';
import 'package:ai_mud/global/system_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:markdown_widget/markdown_widget.dart';

class EventBoard extends ConsumerStatefulWidget {
  const EventBoard({super.key});

  @override
  ConsumerState<EventBoard> createState() => _EventBoardState();
}

class _EventBoardState extends ConsumerState<EventBoard> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      ref
          .read(gameProvider.notifier)
          .plot(await ref.read(systemProvider.notifier).getCurrent());
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(gameProvider);

    return Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width * 0.95,
        height: MediaQuery.of(context).size.height - 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: SingleChildScrollView(
          controller: ref.read(gameProvider.notifier).controller,
          child: MarkdownBlock(
            data: state.dialog,
            selectable: false,
            config: MarkdownConfig.defaultConfig,
          ),
        ),
      ),
    );
  }
}
