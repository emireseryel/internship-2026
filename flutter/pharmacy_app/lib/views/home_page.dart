import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:pharmacy_app/viewmodels/home_viewmodel.dart';
import 'package:pharmacy_app/viewmodels/result_viewmodel.dart';
import 'package:pharmacy_app/viewmodels/language_viewmodel.dart';
import 'package:pharmacy_app/viewmodels/theme_viewmodel.dart';
import 'package:pharmacy_app/views/result_page.dart';
import 'package:provider/provider.dart';
import 'package:pharmacy_app/themes/locale_keys.g.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final cities = context.select<HomeViewModel, List<String>>(
      (vm) => vm.cities,
    );
    final selectedCity = context.select<HomeViewModel, String>(
      (vm) => vm.selectedCity,
    );
    final selectedDistrict = context.select<HomeViewModel, String?>(
      (vm) => vm.selectedDistrict,
    );
    final districts = context.select<HomeViewModel, List<dynamic>>(
      (vm) => vm.districts,
    );

    
    final currentLang = context.select<LanguageViewModel, String>(
      (vm) => vm.getCurrentLanguageName(context),
    );
    final languageList = context.select<LanguageViewModel, List<String>>(
      (vm) => vm.languages,
    );
    
    print('home init edildi');
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(65),
        child: AppBar(
          title: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, right: 15),
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: Image.asset(
                    'assets/images/pharmacy-logo.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Text(
                LocaleKeys.home_page.tr(),
                style: const TextStyle(fontSize: 30),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const InfoBox(),

              const SizedBox(height: 10),

              Container(
                margin: const EdgeInsets.only(top: 20),
                child: Text(
                  LocaleKeys.home_title.tr(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 36,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              DropdownButtonFormField<String>(
                hint: Text(LocaleKeys.select_city.tr()),
                value: selectedCity.isEmpty ? null : selectedCity,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 12,
                  ),
                ),
                items: cities
                    .map(
                      (city) =>
                          DropdownMenuItem(value: city, child: Text(city)),
                    )
                    .toList(),
                onChanged: (newValue) {
                  if (newValue != null) {
                    context.read<HomeViewModel>().selectCity(city: newValue);
                  }
                },
              ),

              const SizedBox(height: 16),

              DropdownButtonFormField<String>(
                hint: Text(LocaleKeys.select_district.tr()),
                value:
                    (selectedDistrict != null &&
                        districts.any((e) => e['text'] == selectedDistrict))
                    ? selectedDistrict
                    : null,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 12,
                  ),
                ),
                items: districts.map((district) {
                  return DropdownMenuItem<String>(
                    value: district['text'],
                    child: Text(district['text']),
                  );
                }).toList(),
                onChanged: (newValue) {
                  if (newValue != null) {
                    context.read<HomeViewModel>().selectDistrict(
                      district: newValue,
                    );
                  }
                },
              ),

              const SizedBox(height: 20),

              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  if (selectedDistrict != null && selectedDistrict.isNotEmpty) {
                    context.read<ResultViewModel>().loadPharmacies(
                      city: selectedCity,
                      district: selectedDistrict,
                    );

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResultPage(
                          city: selectedCity,
                          dist: selectedDistrict,
                        ),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(LocaleKeys.warning_select_district.tr()),
                      ),
                    );
                  }
                },
                icon: const Icon(Icons.search),
                label: const Text(''),
              ),

              const SizedBox(height: 40),
              
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const ThemeToggleSwitch(),
                  const SizedBox(width: 20),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      hint: const Text('dil seçin'),
                      value: currentLang,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 12,
                        ),
                      ),
                      items: languageList.map((lang) {
                        return DropdownMenuItem<String>(
                          value: lang,
                          child: Text(lang),
                        );
                      }).toList(),
                      onChanged: (String? newValue) async {
                        if (newValue != null){
                          await context.read<LanguageViewModel>().changeLanguage(context, newValue);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InfoBox extends StatelessWidget {
  const InfoBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.red.shade200),
      ),
      child: Row(
        children: [
          const Icon(Icons.info_outline, color: Colors.red),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              LocaleKeys.info.tr(),
              style: TextStyle(
                color: Theme.of(context).colorScheme.onErrorContainer,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ThemeToggleSwitch extends StatelessWidget {
  const ThemeToggleSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModelTheme = context.watch<ThemeViewModel>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(LocaleKeys.theme.tr(), style: const TextStyle(fontSize: 20)),
        const SizedBox(width: 10),
        Switch(
          value:
              viewModelTheme.themeMode == ThemeMode.dark ||
              (viewModelTheme.themeMode == ThemeMode.system &&
                  Theme.of(context).brightness == Brightness.dark),
          onChanged: (value) =>
              context.read<ThemeViewModel>().toggleTheme(context),
        ),
      ],
    );
  }
}