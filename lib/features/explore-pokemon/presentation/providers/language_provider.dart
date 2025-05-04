import 'package:flutter_riverpod/flutter_riverpod.dart';

final languageProvider =
    StateNotifierProvider<LanguageNotifier, LanguageState>((ref) {
  return LanguageNotifier();
});

class LanguageNotifier extends StateNotifier<LanguageState> {
  LanguageNotifier() : super(const LanguageState());

  void setLanguage(AppLanguage language) {
    state = state.copyWith(selectedLanguage: language);
  }
}

enum AppLanguage {
  japanese('ja-Hrkt', 'Japonés', 'ポケモン図鑑'),
  english('en', 'Inglés', 'Pokédex'),
  spanish('es', 'Español', 'Pokédex');

  final String code;
  final String name;
  final String title;

  const AppLanguage(this.code, this.name, this.title);
}

class LanguageState {
  final AppLanguage selectedLanguage;

  const LanguageState({this.selectedLanguage = AppLanguage.english});

  LanguageState copyWith({AppLanguage? selectedLanguage}) {
    return LanguageState(
      selectedLanguage: selectedLanguage ?? this.selectedLanguage,
    );
  }
}
