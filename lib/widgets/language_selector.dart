import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/language_model.dart';

class LanguageSelector extends StatelessWidget {
  final LanguageModel selected;
  final List<LanguageModel> languages;
  final ValueChanged<LanguageModel> onChanged;
  final Color accentColor;
  final bool inverted;

  const LanguageSelector({
    super.key,
    required this.selected,
    required this.languages,
    required this.onChanged,
    required this.accentColor,
    this.inverted = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: accentColor.withOpacity(0.12),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: accentColor.withOpacity(0.4), width: 1.5),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<LanguageModel>(
          value: selected,
          dropdownColor: const Color(0xFF1C1C2E),
          icon: Icon(Icons.language, color: accentColor, size: 20),
          isExpanded: true,
          style: GoogleFonts.outfit(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
          onChanged: (v) {
            if (v != null) onChanged(v);
          },
          selectedItemBuilder: (context) {
            return languages.map((lang) {
              return Row(
                children: [
                  Text(lang.flag, style: const TextStyle(fontSize: 18)),
                  const SizedBox(width: 8),
                  Text(lang.nativeScript,
                      style: GoogleFonts.outfit(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      )),
                  const SizedBox(width: 4),
                  Text('(${lang.name})',
                      style: GoogleFonts.outfit(
                        color: Colors.white54,
                        fontSize: 12,
                      )),
                ],
              );
            }).toList();
          },
          items: languages.map((lang) {
            final isSelected = lang.code == selected.code;
            return DropdownMenuItem<LanguageModel>(
              value: lang,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 4),
                decoration: isSelected
                    ? BoxDecoration(
                        color: accentColor.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(8),
                      )
                    : null,
                child: Row(
                  children: [
                    Text(lang.flag, style: const TextStyle(fontSize: 18)),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(lang.nativeScript,
                              style: GoogleFonts.outfit(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              )),
                          Text(lang.name,
                              style: GoogleFonts.outfit(
                                color: Colors.white54,
                                fontSize: 12,
                              )),
                        ],
                      ),
                    ),
                    if (isSelected)
                      Icon(Icons.check_circle, color: accentColor, size: 18),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
