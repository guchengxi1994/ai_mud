import 'package:ai_mud/opening/components/new_game_type_selection.dart';
import 'package:ai_mud/opening/notifiers/new_game_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
            children: const [NewGameTypeSelection()],
          )),
          SizedBox(
            height: 50,
            child: Row(
              children: [
                const Spacer(),
                ElevatedButton(
                    onPressed: ref.watch(newGameProvider.notifier).valid
                        ? () {
                            Navigator.of(context).pop();
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
