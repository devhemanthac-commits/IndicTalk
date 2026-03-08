# IndicBridge 🗣️🇮🇳

> Break language barriers instantly — IndicBridge enables real-time, two-way speech translation across all 22 official Indian languages. Simply hold the mic, speak naturally, and hear the translation aloud. Perfect for face-to-face conversations between people who speak different languages. Powered by Google Gemini AI.

---

## ✨ Features

- 🎙️ **Push-to-Talk** — Hold the mic button to speak, release to translate
- 🔁 **Two-Way Translation** — Both speakers can talk in their own language
- 🧑‍🤝‍🧑 **Face-to-Face Mode** — Top panel is rotated 180° so both people can read from the same phone
- 🌐 **22 Indian Languages** — All scheduled languages including Hindi, Tamil, Telugu, Kannada, Malayalam, Bengali, Gujarati, Marathi, Punjabi, Odia, Urdu, Assamese, Sanskrit, Kashmiri, Konkani, Maithili, Manipuri, Nepali, Santali, Sindhi, Dogri, and Bodo
- 🤖 **Gemini 1.5 Flash** — Fast, culturally-aware translations with natural tone preservation
- 🔊 **Auto Text-to-Speech** — Translations are spoken aloud immediately after processing
- 💫 **Pulse Animation** — Visual feedback during recording

---

## 📱 Screenshots

> Coming soon — run the app on your device to see it in action!

---

## 🛠️ Tech Stack

| Layer | Technology |
|---|---|
| Framework | Flutter 3.22+ |
| State Management | Riverpod 2.x |
| Translation AI | Google Gemini 1.5 Flash |
| Speech-to-Text | `speech_to_text` |
| Text-to-Speech | `flutter_tts` |
| UI Animations | `flutter_animate`, `animate_do` |
| Typography | Google Fonts (Poppins) |

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK ≥ 3.22 — [Install Flutter](https://flutter.dev/docs/get-started/install/windows)
- Android Studio (for Android SDK & emulator)
- A Gemini API key — [Get one free](https://aistudio.google.com/app/apikey)

### 1. Clone the Repository

```bash
git clone https://github.com/devhemanthac-commits/IndicTalk.git
cd IndicTalk
```

### 2. Add Your Gemini API Key

Open `lib/services/gemini_service.dart` and replace:

```dart
static const String _apiKey = 'YOUR_GEMINI_API_KEY_HERE';
```

with your actual key.

### 3. Install Dependencies

```bash
flutter pub get
```

### 4. Run the App

```bash
flutter run
```

> Make sure an Android device is connected with **USB Debugging** enabled, or an emulator is running.

---

## 📂 Project Structure

```
lib/
├── main.dart                        ← Entry point + Splash screen
├── models/
│   └── language_model.dart          ← 22 Indian languages with ISO codes
├── services/
│   ├── gemini_service.dart          ← Gemini 1.5 Flash translation
│   ├── stt_service.dart             ← Speech-to-Text wrapper
│   └── tts_service.dart             ← Text-to-Speech wrapper
├── providers/
│   └── translation_provider.dart    ← Riverpod StateNotifier
├── screens/
│   └── home_screen.dart             ← Face-to-face split layout
└── widgets/
    ├── language_selector.dart        ← Language dropdown
    ├── ptt_button.dart               ← Push-to-Talk + pulse animation
    └── translation_display.dart      ← Animated result panel
```

---

## 🌍 Supported Languages

| Language | Native Script | ISO Code |
|---|---|---|
| Hindi | हिंदी | hi |
| Bengali | বাংলা | bn |
| Telugu | తెలుగు | te |
| Tamil | தமிழ் | ta |
| Marathi | मराठी | mr |
| Gujarati | ગુજરાતી | gu |
| Kannada | ಕನ್ನಡ | kn |
| Malayalam | മലയാളം | ml |
| Punjabi | ਪੰਜਾਬੀ | pa |
| Odia | ଓଡ଼ିଆ | or |
| Assamese | অসমীয়া | as |
| Urdu | اردو | ur |
| Sanskrit | संस्कृतम् | sa |
| Kashmiri | كٲشُر | ks |
| Konkani | कोंकणी | kok |
| Maithili | मैथिली | mai |
| Manipuri | মৈতৈলোন্ | mni |
| Nepali | नेपाली | ne |
| Santali | ᱥᱟᱱᱛᱟᱲᱤ | sat |
| Sindhi | سنڌي | sd |
| Dogri | डोगरी | doi |
| Bodo | बड़ो | brx |

---

## ⚠️ Notes

- **Maithili, Santali, Dogri, Bodo, Konkani** fall back to nearby TTS locales (Hindi/Marathi) as Android TTS doesn't have dedicated voices for them yet.
- `speech_to_text` quality depends on your device microphone and network connectivity.
- The app is locked to **portrait orientation** — the 180° flip handles the face-to-face requirement.

---

## 📄 License

This project is open-source. Feel free to fork, modify, and improve it!

---

<p align="center">Made with ❤️ for India's linguistic diversity</p>
