import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy_app/viewmodels/detail_viewmodel.dart';
import 'package:pharmacy_app/models/pharmacy_model.dart';
import 'package:provider/provider.dart';
import 'package:pharmacy_app/themes/locale_keys.g.dart';

class DetailPage extends StatelessWidget {
  final Pharmacy pharmacy;

  const DetailPage({super.key, required this.pharmacy});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<DetailViewModel>();

    
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
                  width: 45,
                  height: 45,
                  child: Image.asset(
                    'assets/images/pharmacy-logo.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Text(LocaleKeys.detail_page.tr()),
            ],
          ),
          actions: [
            IconButton(
              icon: Icon(
                 viewModel.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: viewModel.isFavorite ? Colors.red : null,
              ),
              onPressed: () => viewModel.toggleFavorite(pharmacy.name),
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                pharmacy.name,
                style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Icon(Icons.location_on, color: Colors.red),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    "${LocaleKeys.detail_district.tr()} ${pharmacy.address}",
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                const Icon(Icons.phone, color: Colors.green),
                const SizedBox(width: 8),
                Text(
                  "${LocaleKeys.detail_phone.tr()} ${pharmacy.phone}",
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}