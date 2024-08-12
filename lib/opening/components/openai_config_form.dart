import 'package:ai_mud/common/app_style.dart';
import 'package:flutter/material.dart';

class OpenaiConfigForm extends StatefulWidget {
  const OpenaiConfigForm({super.key});

  @override
  State<OpenaiConfigForm> createState() => _OpenaiConfigFormState();
}

class _OpenaiConfigFormState extends State<OpenaiConfigForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _apiKeyController = TextEditingController();
  final TextEditingController _apiBaseUrlController = TextEditingController();
  final TextEditingController _modelController = TextEditingController();
  final TextEditingController _temperatureController = TextEditingController();
  final TextEditingController _tagController = TextEditingController();

  final FocusNode _nameFocus = FocusNode();
  final FocusNode _apiKeyFocus = FocusNode();
  final FocusNode _apiBaseUrlFocus = FocusNode();
  final FocusNode _modelFocus = FocusNode();
  final FocusNode _temperatureFocus = FocusNode();
  final FocusNode _tagFocus = FocusNode();

  @override
  void dispose() {
    // Clean up the controller and focus nodes when the widget is disposed.
    _nameController.dispose();
    _apiKeyController.dispose();
    _apiBaseUrlController.dispose();
    _modelController.dispose();
    _temperatureController.dispose();
    _tagController.dispose();
    _nameFocus.dispose();
    _apiKeyFocus.dispose();
    _apiBaseUrlFocus.dispose();
    _modelFocus.dispose();
    _temperatureFocus.dispose();
    _tagFocus.dispose();
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
                    TextFormField(
                      controller: _nameController,
                      focusNode: _nameFocus,
                      onFieldSubmitted: (value) {
                        FocusScope.of(context).requestFocus(_apiKeyFocus);
                      },
                      decoration: AppStyle.inputDecorationWithHintAndLabel(
                          "Input config name", "Name"),
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
                        FocusScope.of(context).requestFocus(_tagFocus);
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
                    TextFormField(
                      controller: _tagController,
                      focusNode: _tagFocus,
                      onFieldSubmitted: (value) {
                        FocusScope.of(context)
                            .unfocus(); // Unfocus after last field
                      },
                      decoration: AppStyle.inputDecorationWithHintAndLabel(
                          "Input config tag", "Tag"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            )),
            SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // If the form is valid, do something with the data.
                    // ignore: avoid_print
                    print('Form is valid!');
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
