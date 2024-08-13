import 'package:ai_mud/common/app_style.dart';
import 'package:ai_mud/opening/components/openai_config_form.dart';
import 'package:ai_mud/settings/notifiers/settings_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(settingsProvider);

    return Scaffold(
      body: Container(
        child: state.when(
            data: (v) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: const Icon(Icons.close),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Token Usage',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 100,
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 100,
                          ),
                          SizedBox(
                            width: 100,
                            child: TextField(
                              controller: TextEditingController(
                                  text: v.tokenUsedToday.toString()),
                              enabled: false,
                              decoration:
                                  AppStyle.inputDecorationWithHintAndLabel(
                                      "", "Today"),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: Text("/"),
                          ),
                          SizedBox(
                            width: 100,
                            child: TextField(
                              controller: TextEditingController(
                                  text: v.tokenUsedTotal.toString()),
                              enabled: false,
                              decoration:
                                  AppStyle.inputDecorationWithHintAndLabel(
                                      "", "Total"),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Models',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 100),
                        child: ListView.builder(
                          itemCount: v.configs.length,
                          itemBuilder: (context, index) {
                            final config = v.configs[index];
                            return Container(
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              margin:
                                  const EdgeInsets.only(top: 10, bottom: 10),
                              child: Material(
                                elevation: 10,
                                borderRadius: BorderRadius.circular(10),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(10),
                                  onTap: () {
                                    showGeneralDialog(
                                        context: context,
                                        barrierColor: Colors.transparent,
                                        barrierDismissible: true,
                                        barrierLabel: "config-form-$index",
                                        pageBuilder: (c, _, __) {
                                          return Center(
                                            child: OpenaiConfigForm(
                                              config: v.configs[index],
                                            ),
                                          );
                                        });
                                  },
                                  child: Center(
                                    child: Text(config.tag),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            error: (e, s) {
              return Center(
                child: Text(e.toString()),
              );
            },
            loading: () => const Center(
                  child: CircularProgressIndicator(),
                )),
      ),
    );
  }
}
