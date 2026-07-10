import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:pharmacy_app/viewmodels/home_viewmodel.dart';
import 'package:pharmacy_app/viewmodels/result_viewmodel.dart';
import 'package:pharmacy_app/viewmodels/theme_viewmodel.dart';
import 'package:pharmacy_app/views/result_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Widget _buildDecorationBox(BuildContext context) {
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
              'info'.tr(),
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

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<HomeViewModel>();
    final viewModelTheme = context.watch<ThemeViewModel>();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(65),
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
              Text('home_page'.tr(), style: const TextStyle(fontSize: 30)),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildDecorationBox(context),

                  const SizedBox(height: 20),

                  Container(
                    margin: const EdgeInsets.only(top: 30),
                    height: 80,
                    child: Text(
                      'home_title'.tr(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: DropdownButtonFormField<String>(
                            hint: Text('select_city'.tr()),
                            value: null,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                            ),
                            items: viewModel.cities
                                .map(
                                  (city) => DropdownMenuItem(
                                    value: city,
                                    child: Text(city),
                                  ),
                                )
                                .toList(),
                            onChanged: (newValue) {
                              if (newValue != null) {
                                viewModel.selectCity(city: newValue);
                              }
                            },
                          ),
                        ),
                      ),

                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: DropdownButtonFormField<String>(
                            hint: Text('select_district'.tr()),
                            value:
                                viewModel.districts.any(
                                  (element) =>
                                      element['text'] ==
                                      viewModel.selectedDistrict,
                                )
                                ? viewModel.selectedDistrict
                                : null,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                            ),
                            items: viewModel.districts.map((district) {
                              return DropdownMenuItem<String>(
                                value: district['text'],
                                child: Text(district['text']),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              if (newValue != null) {
                                viewModel.selectDistrict(district: newValue);
                              }
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),

                      ElevatedButton(
                        onPressed: () {
                          if (viewModel.selectedDistrict != null &&
                              viewModel.selectedDistrict!.isNotEmpty) {
                            context.read<ResultViewModel>().fetchPharmacies(
                              city: viewModel.selectedCity,
                              district: viewModel.selectedDistrict!,
                            );

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ResultPage(
                                  city: viewModel.selectedCity,
                                  dist: viewModel.selectedDistrict!,
                                ),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('warning_select_district'.tr()),
                              ),
                            );
                          }
                        },
                        child: const Icon(Icons.search),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 40,
                  ), // Üstteki dropdown'lardan biraz uzaklaşsın

                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.start, // Sol tarafta dursun
                    children: [
                      Text('theme'.tr(), style: TextStyle(fontSize: 24)),
                      Switch(
                        value:
                            viewModelTheme.themeMode == ThemeMode.dark ||
                            (viewModelTheme.themeMode == ThemeMode.system &&
                                Theme.of(context).brightness ==
                                    Brightness.dark),
                        onChanged: (value) =>
                            context.read<ThemeViewModel>().toggleTheme(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
