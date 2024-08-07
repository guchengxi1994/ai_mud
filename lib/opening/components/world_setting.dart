import 'dart:async';

import 'package:ai_mud/global/system_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langchain_lib/langchain_lib.dart';
import 'package:markdown_widget/markdown_widget.dart';

class WorldSettingWidget extends ConsumerStatefulWidget {
  const WorldSettingWidget({super.key, required this.type, this.details = ""});
  final String type;
  final String details;

  @override
  ConsumerState<WorldSettingWidget> createState() => _WorldSettingWidgetState();
}

class _WorldSettingWidgetState extends ConsumerState<WorldSettingWidget> {
  // ignore: prefer_final_fields
  final StreamController<ChatResult> _streamController =
      StreamController<ChatResult>();

  final ScrollController controller = ScrollController();

  @override
  void dispose() {
    _streamController.close();
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _streamController.addStream(ref.read(systemProvider.notifier).generateWorld(
          widget.type,
          () {
            setState(() {
              finished = true;
            });
          },
          details: widget.details,
          onData: (p0) {
            controller.jumpTo(controller.position.maxScrollExtent);
          },
        ));
  }

  String content = "";
  bool finished = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      child: Container(
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(10),
            color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: SingleChildScrollView(
              controller: controller,
              child: StreamBuilder(
                  stream: _streamController.stream,
                  builder: (c, s) {
                    if (s.hasData) {
                      content += s.data!.output.content;
                    }
                    return MarkdownBlock(
                      data: content,
                      selectable: false,
                      config: MarkdownConfig.defaultConfig,
                    );
                  }),
            )),
            SizedBox(
              height: 30,
              child: Row(
                children: [
                  const Spacer(),
                  if (finished)
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            content = "";
                            finished = false;
                          });
                          _streamController.addStream(
                              ref.read(systemProvider.notifier).generateWorld(
                                    widget.type,
                                    () {
                                      setState(() {
                                        finished = true;
                                      });
                                    },
                                    details: widget.details,
                                    onData: (p0) {
                                      controller.jumpTo(
                                          controller.position.maxScrollExtent);
                                    },
                                  ));
                        },
                        child: const Icon(
                          Icons.refresh,
                          color: Colors.amber,
                        )),
                  const SizedBox(
                    width: 40,
                  ),
                  if (finished)
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop(content);
                        },
                        child: const Icon(
                          Icons.check,
                          color: Colors.green,
                        )),
                  const SizedBox(
                    width: 40,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop(null);
                      },
                      child: const Icon(
                        Icons.cancel,
                        color: Colors.red,
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
