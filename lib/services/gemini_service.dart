import 'package:google_generative_ai/google_generative_ai.dart';
import '../models/language_model.dart';

class GeminiService {
  // 🔑 Replace with your actual Gemini API key
  static const String _apiKey = 'YOUR_GEMINI API KEY';

  late final GenerativeModel _model;

  GeminiService() {
    _model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: _apiKey,
    );
  }

  Future<String> translate(
    String text,
    LanguageModel from,
    LanguageModel to,
  ) async {
    if (text.trim().isEmpty) return '';

    final systemInstruction =
        'You are a dedicated translation device. '
        'Translate the input from ${from.name} to ${to.name}. '
        'Provide ONLY the translated text in ${to.nativeScript} native script. '
        'Maintain cultural nuances and informal tone if the speaker is informal.';

    final model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: _apiKey,
      systemInstruction: Content.system(systemInstruction),
    );

    final response = await model.generateContent([
      Content.text(text),
    ]);

    return response.text?.trim() ?? '';
  }
}
