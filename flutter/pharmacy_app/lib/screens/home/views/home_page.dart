import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:pharmacy_app/core/providers/language_viewmodel.dart';
import 'package:pharmacy_app/core/providers/theme_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:pharmacy_app/localization/locale_keys.g.dart';


import '../viewmodels/home_viewmodel.dart'; 

import '../widgets/city_dropdown.dart';
import '../widgets/district_dropdown.dart';
import '../widgets/search_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = HomeViewModel();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentLang = context.select<LanguageViewModel, String>(
      (vm) => vm.getCurrentLanguageName(),
    );
    final languageList = context.select<LanguageViewModel, List<String>>(
      (vm) => vm.languages,
    );

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

              CityDropdown(viewModel: _viewModel),

              const SizedBox(height: 16),

              DistrictDropdown(viewModel: _viewModel),

              const SizedBox(height: 20),

              SearchButton(viewModel: _viewModel),

              const SizedBox(height: 40),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const ThemeToggleSwitch(),
                  const SizedBox(width: 20),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      hint: const Text('dil seçin'),
                      initialValue: currentLang,
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
                        if (newValue != null) {
                          await context
                              .read<LanguageViewModel>()
                              .changeLanguage(context, newValue);
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