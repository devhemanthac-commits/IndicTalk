import 'package:speech_to_text/speech_to_text.dart';

class SttService {
  final SpeechToText _speech = SpeechToText();
  bool _isAvailable = false;

  Future<bool> init() async {
    _isAvailable = await _speech.initialize(
      onError: (error) => print('STT error: $error'),
      onStatus: (status) => print('STT status: $status'),
    );
    return _isAvailable;
  }

  bool get isAvailable => _isAvailable;
  bool get isListening => _speech.isListening;

  Future<void> startListening({
    required String localeId,
    required void Function(String text, bool isFinal) onResult,
  }) async {
    if (!_isAvailable) return;
    await _speech.listen(
      localeId: localeId,
      onResult: (result) {
        onResult(result.recognizedWords, result.finalResult);
      },
      listenFor: const Duration(seconds: 60),
      pauseFor: const Duration(seconds: 4),
      partialResults: true,
      cancelOnError: false,
    );
  }

  Future<void> stopListening() async {
    await _speech.stop();
  }

  Future<void> cancel() async {
    await _speech.cancel();
  }
}
