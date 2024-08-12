import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:blur/blur.dart';
import 'package:langchain_lib/langchain_lib.dart';

import 'components/buttons.dart';
import 'components/openai_config_form.dart';
import 'notifiers/blur_notifier.dart';

class OpeningPage extends ConsumerWidget {
  const OpeningPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final blurState = ref.watch(blurProvider);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (OpenaiClient.models == null) {
        showGeneralDialog(
            context: context,
            barrierColor: Colors.transparent,
            barrierDismissible: true,
            barrierLabel: "config-form",
            pageBuilder: (c, _, __) {
              return const Center(
                child: OpenaiConfigForm(),
              );
            });
      }
    });

    return Scaffold(
      body: SafeArea(
          child: GestureDetector(
        onTap: () {
          ref.read(blurProvider.notifier).changeState();
        },
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/background.jpeg"),
                      fit: BoxFit.cover)),
            ).blurred(
                blur: blurState ? 5 : 0, colorOpacity: blurState ? 0.1 : 0),
            Visibility(
              visible: blurState && OpenaiClient.models != null,
              child: const OpeningScreenButtons(),
            )
          ],
        ),
      )),
    );
  }
}
