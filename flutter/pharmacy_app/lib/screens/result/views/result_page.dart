import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:pharmacy_app/models/pharmacy_model.dart';
import 'package:pharmacy_app/screens/result/viewmodels/result_viewmodel.dart';
import 'package:pharmacy_app/screens/detail/views/detail_page.dart';
import 'package:pharmacy_app/localization/locale_keys.g.dart';

class ResultPage extends StatefulWidget {
  final String city;
  final String dist;

  const ResultPage({super.key, required this.city, required this.dist});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  late final ResultViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = ResultViewModel();
    _viewModel.fetchPharmacies(city: widget.city, district: widget.dist);
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(65),
        child: AppBar(
          titleSpacing: 0,
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
              Text(LocaleKeys.result_page.tr()),
            ],
          ),
        ),
      ),
      body: ValueListenableBuilder<bool>(
        valueListenable: _viewModel.isLoading,
        builder: (context, isloading, child) {
          if (isloading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (_viewModel.hasError.value) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 60),
                  const SizedBox(height: 10),
                  Text(
                    LocaleKeys.network_api_error.tr(),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            );
          }

          return ValueListenableBuilder<List<Pharmacy>>(
            valueListenable: _viewModel.pharmacies,
            builder: (context, pharmacies, child) {
              if (pharmacies.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.search_off,
                        color: Colors.amber,
                        size: 60,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        LocaleKeys.warning_not_found.tr(),
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                );
              }

              return ListView.builder(
                itemCount: pharmacies.length,
                itemBuilder: (context, index) {
                  final pharmacy = pharmacies[index];
                  return ListTile(
                    leading: Image.asset(
                      'assets/images/pharmacy-icon.png',
                      width: 40,
                      height: 40,
                    ),
                    title: Text(pharmacy.name),
                    subtitle: Text(pharmacy.dist),
                    trailing: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DetailPage(pharmacy: pharmacy),
                          ),
                        );
                      },
                      child: Text(LocaleKeys.see_details.tr()),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
