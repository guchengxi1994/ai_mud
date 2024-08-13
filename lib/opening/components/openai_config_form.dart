import 'package:ai_mud/common/app_style.dart';
import 'package:ai_mud/isar/database.dart';
import 'package:ai_mud/isar/openai_config_history.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class OpenaiConfigForm extends StatefulWidget {
  const OpenaiConfigForm({super.key, this.config});
  final OpenaiConfigHistory? config;

  @override
  State<OpenaiConfigForm> createState() => _OpenaiConfigFormState();
}

class _OpenaiConfigFormState extends State<OpenaiConfigForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final IsarDatabase database = IsarDatabase();

  final TextEditingController _apiKeyController = TextEditingController();
  final TextEditingController _apiBaseUrlController = TextEditingController();
  final TextEditingController _modelController = TextEditingController();
  final TextEditingController _temperatureController = TextEditingController();
  final TextEditingController _tagController = TextEditingController();

  final FocusNode _apiKeyFocus = FocusNode();
  final FocusNode _apiBaseUrlFocus = FocusNode();
  final FocusNode _modelFocus = FocusNode();
  final FocusNode _temperatureFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    if (widget.config != null) {
      _apiKeyController.text = widget.config!.apiKey;
      _apiBaseUrlController.text = widget.config!.apiBaseUrl;
      _modelController.text = widget.config!.model;
      _temperatureController.text = widget.config!.temperature.toString();
      _tagController.text = widget.config!.tag;
    }
  }

  @override
  void dispose() {
    // Clean up the controller and focus nodes when the widget is disposed.
    _apiKeyController.dispose();
    _apiBaseUrlController.dispose();
    _modelController.dispose();
    _temperatureController.dispose();
    _tagController.dispose();
    _apiKeyFocus.dispose();
    _apiBaseUrlFocus.dispose();
    _modelFocus.dispose();
    _temperatureFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      elevation: 10,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.8,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 50,
              child: Text(
                "OpenAI Config",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 50,
              child: Text(
                "Please provide a valid config to use this app",
              ),
            ),
            Expanded(
                child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _apiKeyController,
                      focusNode: _apiKeyFocus,
                      onFieldSubmitted: (value) {
                        FocusScope.of(context).requestFocus(_apiBaseUrlFocus);
                      },
                      decoration: AppStyle.inputDecorationWithHintAndLabel(
                          "Input config Api key", "Api key"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _apiBaseUrlController,
                      focusNode: _apiBaseUrlFocus,
                      onFieldSubmitted: (value) {
                        FocusScope.of(context).requestFocus(_modelFocus);
                      },
                      decoration: AppStyle.inputDecorationWithHintAndLabel(
                          "Input config api base url", "Api base url"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _modelController,
                      focusNode: _modelFocus,
                      onFieldSubmitted: (value) {
                        FocusScope.of(context).requestFocus(_temperatureFocus);
                      },
                      decoration: AppStyle.inputDecorationWithHintAndLabel(
                          "Input config model name", "Model"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _temperatureController,
                      focusNode: _temperatureFocus,
                      keyboardType: TextInputType.number,
                      onFieldSubmitted: (value) {
                        FocusScope.of(context)
                            .unfocus(); // Unfocus after last field
                      },
                      decoration: AppStyle.inputDecorationWithHintAndLabel(
                          "Input config temperature", "Temperature"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: TextFormField(
                          enabled: false,
                          controller: _tagController,
                          onFieldSubmitted: (value) {},
                          decoration: AppStyle.inputDecorationWithHintAndLabel(
                              "Input config tag", "Tag"),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        )),
                        SizedBox(
                          width: 30,
                          height: 30,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2(
                              customButton: const Icon(
                                Icons.list,
                                size: 30,
                                color: Colors.black,
                              ),
                              items: [
                                ...modelTypes.map(
                                  (item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: AutoSizeText(
                                      item,
                                      maxLines: 1,
                                    ),
                                  ),
                                ),
                              ],
                              onChanged: (value) {
                                _tagController.text = value ?? modelTypes.first;
                              },
                              dropdownStyleData: DropdownStyleData(
                                width: 200,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 6),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Colors.white,
                                ),
                                offset: const Offset(0, 8),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            )),
            SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await database.isar!.writeTxn(() async {
                      if (widget.config == null) {
                        await database.isar!.openaiConfigHistorys
                            .put(OpenaiConfigHistory()
                              ..apiBaseUrl = _apiBaseUrlController.text
                              ..apiKey = _apiKeyController.text
                              ..model = _modelController.text
                              ..temperature =
                                  double.parse(_temperatureController.text)
                              ..tag = _tagController.text);
                      } else {
                        await database.isar!.openaiConfigHistorys
                            .put(widget.config!
                              ..apiBaseUrl = _apiBaseUrlController.text
                              ..apiKey = _apiKeyController.text
                              ..model = _modelController.text
                              ..temperature =
                                  double.parse(_temperatureController.text)
                              ..tag = _tagController.text);
                      }
                    });

                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pop();
                  }
                },
                child: const Text('Submit'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
