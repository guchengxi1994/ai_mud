import 'package:ai_mud/global/global.dart';
import 'package:ai_mud/opening/notifiers/new_game_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';

import 'active_button.dart';

class NewGameAimsSelection extends ConsumerWidget {
  const NewGameAimsSelection({super.key});

  static SystemConfig config = AiClient().systemConfig;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(newGameProvider);
    final aims =
        config.games.where((e) => e.type == state.worldType).first.aims;

    return Column(
      children: [
        const SizedBox(
          height: 50,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Text("请选择目标"),
          ),
        ),
        Column(
          children: aims
              .mapIndexed((i, v) => ActiveButton(
                  inactiveColor: Colors.grey[300],
                  onTap: (s) {
                    if (s != null) {
                      ref
                          .read(newGameProvider.notifier)
                          .changeAim(s.toString());

                      ref.read(newGameProvider.notifier).jumpTo(3);
                    }
                  },
                  debugLabel: i,
                  content: v))
              .toList(),
        )
      ],
    );
  }
}
