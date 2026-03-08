import 'package:flutter_tts/flutter_tts.dart';

class TtsService {
  final FlutterTts _tts = FlutterTts();

  TtsService() {
    _tts.setVolume(1.0);
    _tts.setSpeechRate(0.5);
    _tts.setPitch(1.0);
  }

  Future<void> speak(String text, String locale) async {
    if (text.trim().isEmpty) return;
    await _tts.setLanguage(locale);
    await _tts.speak(text);
  }

  Future<void> stop() async {
    await _tts.stop();
  }
}
