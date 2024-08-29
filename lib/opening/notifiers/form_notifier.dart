import 'package:flutter_riverpod/flutter_riverpod.dart';

class FormState {
  final String apiKey;
  final String baseUrl;
  final String model;
  final String temperature;
  final String tag;

  FormState({
    this.apiKey = "",
    this.baseUrl = "",
    this.model = "",
    this.temperature = "",
    this.tag = "",
  });

  FormState copyWith({
    String? apiKey,
    String? baseUrl,
    String? model,
    String? temperature,
    String? tag,
  }) {
    return FormState(
      apiKey: apiKey ?? this.apiKey,
      baseUrl: baseUrl ?? this.baseUrl,
      model: model ?? this.model,
      temperature: temperature ?? this.temperature,
      tag: tag ?? this.tag,
    );
  }
}

class FormNotifier extends Notifier<FormState> {
  @override
  FormState build() {
    return FormState();
  }

  updateApiKey(String apiKey) {
    state = state.copyWith(apiKey: apiKey);
  }

  updateBaseUrl(String baseUrl) {
    state = state.copyWith(baseUrl: baseUrl);
  }

  updateModel(String model) {
    state = state.copyWith(model: model);
  }

  updateTemperature(String temperature) {
    state = state.copyWith(temperature: temperature);
  }

  updateTag(String tag) {
    state = state.copyWith(tag: tag);
  }
}

final formNotifierProvider =
    NotifierProvider<FormNotifier, FormState>(FormNotifier.new);
