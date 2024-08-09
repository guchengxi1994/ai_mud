import 'package:ai_mud/game/models/event.dart';
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
      ref.read(gameProvider.notifier).plot(
        await ref.read(systemProvider.notifier).getCurrent(),
        onDone: (event) {
          if (event != null) {
            setState(() {
              e = event;
            });
          }
        },
      );
    });
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
        child: Column(
          children: [
            Expanded(
                child: e == null
                    ? SingleChildScrollView(
                        controller: ref.read(gameProvider.notifier).controller,
                        child: MarkdownBlock(
                          data: state.dialog,
                          selectable: false,
                          config: MarkdownConfig.defaultConfig,
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
                        }
                      : null,
                  child: const Text("重试一次")),
            )
          ],
        ),
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
                        print(v);
                      },
                      child: SizedBox(
                        // margin: const EdgeInsets.only(top: 10, bottom: 10),
                        // decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(10),
                        //     color: Colors.transparent),
                        height: 60,
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Center(
                          child: Text(v),
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
