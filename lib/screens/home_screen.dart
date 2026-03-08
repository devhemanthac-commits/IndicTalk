import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/language_model.dart';
import '../providers/translation_provider.dart';
import '../widgets/language_selector.dart';
import '../widgets/ptt_button.dart';
import '../widgets/translation_display.dart';

const Color _colorA = Color(0xFF2979FF); // Blue – bottom user
const Color _colorB = Color(0xFFFF6D00); // Orange – top user

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(translationProvider);
    final notifier = ref.read(translationProvider.notifier);

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    // The screen is split exactly in half with a divider
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D1A),
      body: SafeArea(
        child: Column(
          children: [
            // ──────────────── TOP HALF (Person B – rotated 180°) ────────────────
            Expanded(
              child: Transform.rotate(
                angle: pi,
                child: _UserPanel(
                  label: 'Person B',
                  language: state.langB,
                  languages: kIndianLanguages,
                  isRecording: state.isRecordingB,
                  isLoading: state.isLoadingB,
                  transcript: state.transcriptB,
                  // Person B's panel shows the translation they SEND (B→A)
                  // and also what A said (A→B arrives as translation)
                  translation: state.translationA,
                  // But for B's transcription panel: show B speaking + A's translation
                  receivedTranslation: state.translationB,
                  receivedTranscript: state.transcriptA,
                  accentColor: _colorB,
                  onLangChanged: notifier.setLangB,
                  onPressStart: notifier.startRecordingB,
                  onPressEnd: notifier.stopRecordingB,
                ),
              ),
            ),

            // ─────────────────────── DIVIDER ────────────────────────────────────
            Container(
              height: 3,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [_colorA, Colors.white12, _colorB],
                ),
              ),
            ),

            // ──────────────── BOTTOM HALF (Person A – normal orientation) ────────
            Expanded(
              child: _UserPanel(
                label: 'Person A',
                language: state.langA,
                languages: kIndianLanguages,
                isRecording: state.isRecordingA,
                isLoading: state.isLoadingA,
                transcript: state.transcriptA,
                translation: state.translationB,
                receivedTranslation: state.translationA,
                receivedTranscript: state.transcriptB,
                accentColor: _colorA,
                onLangChanged: notifier.setLangA,
                onPressStart: notifier.startRecordingA,
                onPressEnd: notifier.stopRecordingA,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Single user panel (used for both top and bottom)
// ─────────────────────────────────────────────────────────────────────────────
class _UserPanel extends StatelessWidget {
  final String label;
  final LanguageModel language;
  final List<LanguageModel> languages;
  final bool isRecording;
  final bool isLoading;
  final String transcript;
  final String translation; // What the OTHER person said (received)
  final String receivedTranslation; // What THIS person sent (outbound translation)
  final String receivedTranscript;
  final Color accentColor;
  final ValueChanged<LanguageModel> onLangChanged;
  final VoidCallback onPressStart;
  final VoidCallback onPressEnd;

  const _UserPanel({
    required this.label,
    required this.language,
    required this.languages,
    required this.isRecording,
    required this.isLoading,
    required this.transcript,
    required this.translation,
    required this.receivedTranslation,
    required this.receivedTranscript,
    required this.accentColor,
    required this.onLangChanged,
    required this.onPressStart,
    required this.onPressEnd,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header row: label + language selector
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: accentColor.withOpacity(0.18),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: accentColor.withOpacity(0.5), width: 1),
                ),
                child: Text(
                  label,
                  style: GoogleFonts.outfit(
                    color: accentColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: LanguageSelector(
                  selected: language,
                  languages: languages,
                  onChanged: onLangChanged,
                  accentColor: accentColor,
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          // Translation display (what the OTHER person said – translated IN to my lang)
          Expanded(
            child: TranslationDisplay(
              transcript: receivedTranscript,
              translation: translation,
              isLoading: false,
              accentColor: accentColor,
              placeholderText:
                  'Translation from the other person will appear here…',
            ),
          ),

          const SizedBox(height: 8),

          // PTT button + outbound transcript
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              PttButton(
                isRecording: isRecording,
                isLoading: isLoading,
                color: accentColor,
                onPressStart: onPressStart,
                onPressEnd: onPressEnd,
                languageName: language.name,
                nativeScript: language.nativeScript,
              ),
              const SizedBox(width: 14),
              Expanded(
                child: TranslationDisplay(
                  transcript: transcript,
                  translation: receivedTranslation,
                  isLoading: isLoading,
                  accentColor: accentColor.withOpacity(0.6),
                  placeholderText: 'Hold mic to speak in ${language.nativeScript}',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
