import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:pharmacy_app/viewmodels/detail_viewmodel.dart';
import 'package:pharmacy_app/viewmodels/result_viewmodel.dart';
import 'package:pharmacy_app/views/detail_page.dart';
import 'package:provider/provider.dart';

class ResultPage extends StatelessWidget {
  final String city;
  final String dist;

  const ResultPage({super.key, required this.city, required this.dist});

  @override
  Widget build(BuildContext context) {
    
    final viewModel = context.watch<ResultViewModel>();

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
              Text('result_page'.tr()),
            ],
          ),
        ),
      ),
      body: viewModel.isLoading
          ? const Center(child: CircularProgressIndicator())
          : viewModel.errorMessage != null
          ? Center(
              child: Text(
                viewModel.errorMessage!,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : viewModel.pharmacies.isEmpty
          ? Center(
              child: Text(
                'warning_not_found'.tr(),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : ListView.builder(
              // Veri geldiyse doğrudan liste
              itemCount: viewModel.pharmacies.length,
              itemBuilder: (context, index) {
                final pharmacy = viewModel.pharmacies[index];

                return ListTile(
                  leading: Image.asset(
                    'assets/images/pharmacy-icon.png',
                    width: 40,
                    height: 40,

                    color: Theme.of(context).iconTheme.color,
                  ),
                  title: Text(pharmacy.name),
                  subtitle: Text(pharmacy.dist),
                  trailing: ElevatedButton(
                    onPressed: () {
                      context.read<DetailViewModel>().loadFavoriteStatus(pharmacy.name);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailPage(pharmacy: pharmacy),
                        ),
                      );
                    },
                    child: Text('see_details'.tr()),
                  ),
                );
              },
            ),
    );
  }
}
