// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Input Form Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                focusNode: _nameFocus,
                onFieldSubmitted: (value) {
                  FocusScope.of(context).requestFocus(_apiKeyFocus);
                },
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _apiKeyController,
                focusNode: _apiKeyFocus,
                onFieldSubmitted: (value) {
                  FocusScope.of(context).requestFocus(_apiBaseUrlFocus);
                },
                decoration: const InputDecoration(labelText: 'API Key'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _apiBaseUrlController,
                focusNode: _apiBaseUrlFocus,
                onFieldSubmitted: (value) {
                  FocusScope.of(context).requestFocus(_modelFocus);
                },
                decoration: const InputDecoration(labelText: 'API Base URL'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _modelController,
                focusNode: _modelFocus,
                onFieldSubmitted: (value) {
                  FocusScope.of(context).requestFocus(_temperatureFocus);
                },
                decoration: const InputDecoration(labelText: 'Model'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _temperatureController,
                focusNode: _temperatureFocus,
                keyboardType: TextInputType.number,
                onFieldSubmitted: (value) {
                  FocusScope.of(context).requestFocus(_tagFocus);
                },
                decoration: const InputDecoration(labelText: 'Temperature'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _tagController,
                focusNode: _tagFocus,
                onFieldSubmitted: (value) {
                  FocusScope.of(context).unfocus(); // Unfocus after last field
                },
                decoration: const InputDecoration(labelText: 'Tag'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // If the form is valid, do something with the data.
                    // ignore: avoid_print
                    print('Form is valid!');
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
