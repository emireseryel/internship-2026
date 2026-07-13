import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class LanguageViewModel extends ChangeNotifier {
  final Map<String, String> _languageMap = {
    'Türkçe': 'tr',
    'English': 'en',
  };

  List<String> get languages => _languageMap.keys.toList();

  String getCurrentLanguageName(BuildContext context){
    final currentLocale = EasyLocalization.of(context)?.locale.languageCode ?? 'tr';

    return _languageMap.entries
        .firstWhere((element) => element.value == currentLocale, orElse: () => _languageMap.entries.first)
        .key;
  }

  Future<void> changeLanguage(BuildContext context,String selectedLanguage) async {
    final rawCode = _languageMap[selectedLanguage];
    
    if (rawCode != null) {
      final locale = Locale(rawCode);
      
      await EasyLocalization.of(context)?.setLocale(locale);
      notifyListeners();
    }
  }
}