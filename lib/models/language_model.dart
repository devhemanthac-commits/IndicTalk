class LanguageModel {
  final String name;
  final String code;
  final String nativeScript;
  final String ttsLocale;
  final String flag;

  const LanguageModel({
    required this.name,
    required this.code,
    required this.nativeScript,
    required this.ttsLocale,
    required this.flag,
  });

  @override
  String toString() => '$nativeScript ($name)';
}

const List<LanguageModel> kIndianLanguages = [
  LanguageModel(name: 'Hindi',     code: 'hi-IN', nativeScript: 'हिन्दी',       ttsLocale: 'hi-IN', flag: '🇮🇳'),
  LanguageModel(name: 'Tamil',     code: 'ta-IN', nativeScript: 'தமிழ்',         ttsLocale: 'ta-IN', flag: '🇮🇳'),
  LanguageModel(name: 'Telugu',    code: 'te-IN', nativeScript: 'తెలుగు',         ttsLocale: 'te-IN', flag: '🇮🇳'),
  LanguageModel(name: 'Kannada',   code: 'kn-IN', nativeScript: 'ಕನ್ನಡ',           ttsLocale: 'kn-IN', flag: '🇮🇳'),
  LanguageModel(name: 'Malayalam', code: 'ml-IN', nativeScript: 'മലയാളം',          ttsLocale: 'ml-IN', flag: '🇮🇳'),
  LanguageModel(name: 'Bengali',   code: 'bn-IN', nativeScript: 'বাংলা',           ttsLocale: 'bn-IN', flag: '🇮🇳'),
  LanguageModel(name: 'Marathi',   code: 'mr-IN', nativeScript: 'मराठी',           ttsLocale: 'mr-IN', flag: '🇮🇳'),
  LanguageModel(name: 'Gujarati',  code: 'gu-IN', nativeScript: 'ગુજરાતી',          ttsLocale: 'gu-IN', flag: '🇮🇳'),
  LanguageModel(name: 'Punjabi',   code: 'pa-IN', nativeScript: 'ਪੰਜਾਬੀ',           ttsLocale: 'pa-IN', flag: '🇮🇳'),
  LanguageModel(name: 'Odia',      code: 'or-IN', nativeScript: 'ଓଡ଼ିଆ',             ttsLocale: 'or-IN', flag: '🇮🇳'),
  LanguageModel(name: 'Sanskrit',  code: 'sa-IN', nativeScript: 'संस्कृतम्',         ttsLocale: 'sa-IN', flag: '🇮🇳'),
  LanguageModel(name: 'Urdu',      code: 'ur-IN', nativeScript: 'اردو',             ttsLocale: 'ur-IN', flag: '🇮🇳'),
  LanguageModel(name: 'Assamese',  code: 'as-IN', nativeScript: 'অসমীয়া',           ttsLocale: 'as-IN', flag: '🇮🇳'),
  LanguageModel(name: 'Maithili',  code: 'mai-IN',nativeScript: 'मैथिली',           ttsLocale: 'hi-IN', flag: '🇮🇳'),
  LanguageModel(name: 'Santali',   code: 'sat-IN',nativeScript: 'ᱚᱞ ᱪᱤᱠᱤ',         ttsLocale: 'hi-IN', flag: '🇮🇳'),
  LanguageModel(name: 'Kashmiri', code: 'ks-IN', nativeScript: 'كٲشُر',            ttsLocale: 'ur-IN', flag: '🇮🇳'),
  LanguageModel(name: 'Konkani',   code: 'kok-IN',nativeScript: 'कोंकणी',           ttsLocale: 'mr-IN', flag: '🇮🇳'),
  LanguageModel(name: 'Sindhi',    code: 'sd-IN', nativeScript: 'سنڌي',            ttsLocale: 'ur-IN', flag: '🇮🇳'),
  LanguageModel(name: 'Dogri',     code: 'doi-IN',nativeScript: 'डोगरी',            ttsLocale: 'hi-IN', flag: '🇮🇳'),
  LanguageModel(name: 'Manipuri',  code: 'mni-IN',nativeScript: 'মৈতৈলোন',          ttsLocale: 'bn-IN', flag: '🇮🇳'),
  LanguageModel(name: 'Nepali',    code: 'ne-IN', nativeScript: 'नेपाली',            ttsLocale: 'ne-IN', flag: '🇮🇳'),
  LanguageModel(name: 'Bodo',      code: 'brx-IN',nativeScript: "बर'",              ttsLocale: 'hi-IN', flag: '🇮🇳'),
];
