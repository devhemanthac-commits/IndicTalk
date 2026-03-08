import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/language_model.dart';
import '../services/gemini_service.dart';
import '../services/stt_service.dart';
import '../services/tts_service.dart';

// ─── Service Providers ───────────────────────────────────────────────────────
final geminiServiceProvider = Provider<GeminiService>((ref) => GeminiService());
final sttServiceProvider = Provider<SttService>((ref) => SttService());
final ttsServiceProvider = Provider<TtsService>((ref) => TtsService());

// ─── State ───────────────────────────────────────────────────────────────────
class TranslationState {
  final LanguageModel langA;
  final LanguageModel langB;

  final bool isRecordingA;
  final bool isRecordingB;

  final String transcriptA;
  final String transcriptB;
  final String translationA; // A → B (shown in B's panel)
  final String translationB; // B → A (shown in A's panel)

  final bool isLoadingA;
  final bool isLoadingB;

  const TranslationState({
    required this.langA,
    required this.langB,
    this.isRecordingA = false,
    this.isRecordingB = false,
    this.transcriptA = '',
    this.transcriptB = '',
    this.translationA = '',
    this.translationB = '',
    this.isLoadingA = false,
    this.isLoadingB = false,
  });

  TranslationState copyWith({
    LanguageModel? langA,
    LanguageModel? langB,
    bool? isRecordingA,
    bool? isRecordingB,
    String? transcriptA,
    String? transcriptB,
    String? translationA,
    String? translationB,
    bool? isLoadingA,
    bool? isLoadingB,
  }) {
    return TranslationState(
      langA: langA ?? this.langA,
      langB: langB ?? this.langB,
      isRecordingA: isRecordingA ?? this.isRecordingA,
      isRecordingB: isRecordingB ?? this.isRecordingB,
      transcriptA: transcriptA ?? this.transcriptA,
      transcriptB: transcriptB ?? this.transcriptB,
      translationA: translationA ?? this.translationA,
      translationB: translationB ?? this.translationB,
      isLoadingA: isLoadingA ?? this.isLoadingA,
      isLoadingB: isLoadingB ?? this.isLoadingB,
    );
  }
}

// ─── Notifier ────────────────────────────────────────────────────────────────
class TranslationNotifier extends StateNotifier<TranslationState> {
  final GeminiService _gemini;
  final SttService _stt;
  final TtsService _tts;

  TranslationNotifier(this._gemini, this._stt, this._tts)
      : super(TranslationState(
          langA: kIndianLanguages[0], // Hindi
          langB: kIndianLanguages[1], // Tamil
        )) {
    _initStt();
  }

  Future<void> _initStt() async {
    await _stt.init();
  }

  void setLangA(LanguageModel lang) => state = state.copyWith(langA: lang);
  void setLangB(LanguageModel lang) => state = state.copyWith(langB: lang);

  // ── Person A (bottom half) presses record ──────────────────────────────────
  Future<void> startRecordingA() async {
    state = state.copyWith(
      isRecordingA: true,
      transcriptA: '',
      translationA: '',
    );
    await _stt.startListening(
      localeId: state.langA.code,
      onResult: (text, isFinal) {
        state = state.copyWith(transcriptA: text);
      },
    );
  }

  Future<void> stopRecordingA() async {
    await _stt.stopListening();
    state = state.copyWith(isRecordingA: false);

    final text = state.transcriptA;
    if (text.isEmpty) return;

    state = state.copyWith(isLoadingA: true);
    try {
      final translation = await _gemini.translate(text, state.langA, state.langB);
      state = state.copyWith(translationA: translation, isLoadingA: false);
      await _tts.speak(translation, state.langB.ttsLocale);
    } catch (e) {
      state = state.copyWith(
        translationA: 'Translation error: $e',
        isLoadingA: false,
      );
    }
  }

  // ── Person B (top half) presses record ────────────────────────────────────
  Future<void> startRecordingB() async {
    state = state.copyWith(
      isRecordingB: true,
      transcriptB: '',
      translationB: '',
    );
    await _stt.startListening(
      localeId: state.langB.code,
      onResult: (text, isFinal) {
        state = state.copyWith(transcriptB: text);
      },
    );
  }

  Future<void> stopRecordingB() async {
    await _stt.stopListening();
    state = state.copyWith(isRecordingB: false);

    final text = state.transcriptB;
    if (text.isEmpty) return;

    state = state.copyWith(isLoadingB: true);
    try {
      final translation = await _gemini.translate(text, state.langB, state.langA);
      state = state.copyWith(translationB: translation, isLoadingB: false);
      await _tts.speak(translation, state.langA.ttsLocale);
    } catch (e) {
      state = state.copyWith(
        translationB: 'Translation error: $e',
        isLoadingB: false,
      );
    }
  }

  Future<void> stopTts() async {
    await _tts.stop();
  }
}

// ─── Provider ─────────────────────────────────────────────────────────────────
final translationProvider =
    StateNotifierProvider<TranslationNotifier, TranslationState>((ref) {
  return TranslationNotifier(
    ref.read(geminiServiceProvider),
    ref.read(sttServiceProvider),
    ref.read(ttsServiceProvider),
  );
});
