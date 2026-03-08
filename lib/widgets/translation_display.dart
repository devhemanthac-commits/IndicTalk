import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TranslationDisplay extends StatelessWidget {
  final String transcript;
  final String translation;
  final bool isLoading;
  final Color accentColor;
  final String placeholderText;

  const TranslationDisplay({
    super.key,
    required this.transcript,
    required this.translation,
    required this.isLoading,
    required this.accentColor,
    required this.placeholderText,
  });

  @override
  Widget build(BuildContext context) {
    final hasContent = translation.isNotEmpty || transcript.isNotEmpty;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOut,
      constraints: const BoxConstraints(minHeight: 80),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: hasContent
            ? accentColor.withOpacity(0.07)
            : Colors.white.withOpacity(0.03),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: hasContent
              ? accentColor.withOpacity(0.3)
              : Colors.white.withOpacity(0.07),
          width: 1.2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Translated text (primary)
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 350),
            child: isLoading
                ? Row(
                    key: const ValueKey('loading'),
                    children: [
                      SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(accentColor),
                          strokeWidth: 2,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Translating…',
                        style: GoogleFonts.outfit(
                          color: accentColor.withOpacity(0.7),
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  )
                : translation.isNotEmpty
                    ? Text(
                        translation,
                        key: ValueKey(translation),
                        style: GoogleFonts.notoSans(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          height: 1.5,
                        ),
                      )
                    : Text(
                        placeholderText,
                        key: const ValueKey('placeholder'),
                        style: GoogleFonts.outfit(
                          color: Colors.white24,
                          fontSize: 15,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
          ),
          // Original transcript (small, faded)
          if (transcript.isNotEmpty) ...[
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              height: 1,
              color: accentColor.withOpacity(0.15),
            ),
            const SizedBox(height: 6),
            Text(
              transcript,
              style: GoogleFonts.outfit(
                color: Colors.white38,
                fontSize: 12,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
