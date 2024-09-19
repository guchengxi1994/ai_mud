import 'dart:math';

import 'package:ai_mud/game/components/good_bad_luck_dialog.dart';
import 'package:ai_mud/game/components/special_event_dialog.dart';
import 'package:ai_mud/game/models/event.dart';
import 'package:ai_mud/game/notifiers/game_notifier.dart';
import 'package:ai_mud/global/ai_client.dart';
import 'package:ai_mud/global/system_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:markdown_widget/markdown_widget.dart';

class EventBoard extends ConsumerStatefulWidget {
  const EventBoard({super.key});

  @override
  ConsumerState<EventBoard> createState() => EventBoardState();
}

class EventBoardState extends ConsumerState<EventBoard> {
  @override
  void initState() {
    super.initState();
  }

  final random = Random();
  final settings = AiClient().systemConfig.gameSettings;

  plot() async {
    if (!ref.read(systemProvider.notifier).couldMoveNext()) {
      return;
    }

    int r = random.nextInt(100);

    int goodLuck = (settings.goodLuck * 100).ceil();
    int badLuck = 100 - (settings.badLuck * 100).ceil();

    if (r <= goodLuck) {
      ref.read(systemProvider.notifier).changePlayerMaxAge(5);
      showGeneralDialog(
          context: context,
          barrierColor: Colors.transparent,
          barrierDismissible: true,
          barrierLabel: "good",
          pageBuilder: (c, _, __) {
            return const Center(
              child: GoodBadLuckDialog(
                isGoodLuck: true,
              ),
            );
          });
    } else if (r >= badLuck) {
      ref.read(systemProvider.notifier).changePlayerMaxAge(-5);
      showGeneralDialog(
          context: context,
          barrierColor: Colors.transparent,
          barrierDismissible: true,
          barrierLabel: "bad",
          pageBuilder: (c, _, __) {
            return const Center(
              child: GoodBadLuckDialog(
                isGoodLuck: false,
              ),
            );
          });
    }

    /// special event
    r = random.nextInt(100);
    int special = (settings.specialEventProbability * 100).ceil();
    if (r <= special) {
      final e = AiClient()
          .systemConfig
          .games
          .firstWhere((element) => element.type == "special")
          .specialEvents;

      int index = r % e.length;
      final event = e[index];

      final ability = ref.read(systemProvider.notifier).getAbilitySync();

      showGeneralDialog(
          // ignore: use_build_context_synchronously
          context: context,
          barrierColor: Colors.transparent,
          barrierDismissible: true,
          barrierLabel: "special",
          pageBuilder: (c, _, __) {
            return Center(
              child: SpecialEventDialog(
                eventName: event.eventName,
                satisfied: ability.satisfied(event.conditions),
              ),
            );
          });
    }

    ref.read(gameProvider.notifier).plot(
      await ref.read(systemProvider.notifier).getCurrent(),
      onDone: (event) {
        if (event != null) {
          setState(() {
            e = event;
          });
        } else {
          ref.read(gameProvider.notifier).setError();
        }
      },
    );
  }

  // ignore: avoid_init_to_null
  Event? e = null;

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
        child: Builder(builder: (c) {
          if (!ref.read(systemProvider.notifier).couldMoveNext()) {
            return const Center(
              child: SizedBox(
                child: Text(
                  "Game is over",
                  style: TextStyle(fontSize: 40, fontFamily: "xing"),
                ),
              ),
            );
          }

          return Column(
            children: [
              Expanded(
                  child: e == null
                      ? SingleChildScrollView(
                          controller:
                              ref.read(gameProvider.notifier).controller,
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: MarkdownBlock(
                              data: state.dialog,
                              selectable: false,
                              config: MarkdownConfig.defaultConfig,
                            ),
                          ),
                        )
                      : buildEvent()),
              SizedBox(
                height: 50,
                child: ElevatedButton(
                    onPressed: state.conversationDone
                        ? () {
                            setState(() {
                              e = null;
                            });
                            plot();
                          }
                        : null,
                    child: const Text("重试一次")),
              )
            ],
          );
        }),
      ),
    );
  }

  Widget buildEvent() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                "事件名称: ",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(e!.name)
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "事件内容: ",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Expanded(
                  child: Text(
                e!.content,
                maxLines: null,
              ))
            ],
          ),
          const Text(
            "事件选项: ",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          ...e!.options.map((v) => Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Material(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () {
                        e!.result = "${v.content} => ${v.result}";
                        ref
                            .read(gameProvider.notifier)
                            .saveHistoryToIsar(e!)
                            .then((_) {
                          setState(() {
                            e = null;
                          });
                          plot();
                        });
                      },
                      child: SizedBox(
                        // margin: const EdgeInsets.only(top: 10, bottom: 10),
                        // decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(10),
                        //     color: Colors.transparent),
                        height: 60,
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Center(
                          child: Text(v.content),
                        ),
                      ),
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
