import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:blur/blur.dart';

import 'components/buttons.dart';
import 'notifiers/blur_notifier.dart';

class OpeningPage extends ConsumerWidget {
  const OpeningPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final blurState = ref.watch(blurProvider);

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          ref.read(blurProvider.notifier).changeState();
        },
        child: Stack(
          children: [
            // WorldSettingWidget(
            //   type: "历史角色扮演",
            // )
            Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/background.jpeg"),
                      fit: BoxFit.cover)),
            ).blurred(
                blur: blurState ? 5 : 0, colorOpacity: blurState ? 0.1 : 0),
            Visibility(
              visible: blurState,
              child: const OpeningScreenButtons(),
            )
          ],
        ),
      ),
    );
  }
}
