import 'package:ai_mud/global/system_notifier.dart';
import 'package:ai_mud/opening/components/new_game_type_selection.dart';
import 'package:ai_mud/opening/notifiers/new_game_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'new_game_last_screen.dart';
import 'new_game_role_selection.dart';

class NewGameDialog extends ConsumerWidget {
  const NewGameDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _ = ref.watch(newGameProvider);

    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: PageView(
            controller: ref.read(newGameProvider.notifier).pageController,
            children: const [
              NewGameTypeSelection(),
              NewGameRoleSelection(),
              NewGameLastScreen()
            ],
          )),
          SizedBox(
            height: 50,
            child: Row(
              children: [
                const Spacer(),
                ElevatedButton(
                    onPressed: ref.watch(newGameProvider.notifier).valid
                        ? () {
                            var name = ref
                                .read(newGameProvider.notifier)
                                .controller
                                .text;
                            if (name.isEmpty) {
                              name = "张三";
                            }
                            ref
                                .read(newGameProvider.notifier)
                                .changePlayerName(name);
                            ref
                                .read(systemProvider.notifier)
                                .newGame(ref.watch(newGameProvider))
                                .then((_) {
                              // ignore: use_build_context_synchronously
                              Navigator.of(context).pop(1);
                            });
                          }
                        : null,
                    child: const Text("确定")),
                const SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("取消"))
              ],
            ),
          )
        ],
      ),
    );
  }
}
