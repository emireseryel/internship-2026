import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy_app/screens/detail/viewmodels/detail_viewmodel.dart';
import 'package:pharmacy_app/models/pharmacy_model.dart';
import 'package:pharmacy_app/localization/locale_keys.g.dart';

class DetailPage extends StatefulWidget {
  final Pharmacy pharmacy;

  const DetailPage({super.key, required this.pharmacy});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late final DetailViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = DetailViewModel();
    _viewModel.loadFavoriteStatus(widget.pharmacy.name);
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
            ValueListenableBuilder(
              valueListenable: _viewModel.isFavorite,
              builder: (context, isFavorite, child) {
                return IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : null,
                  ),
                  onPressed: () => _viewModel.toggleFavorite(widget.pharmacy.name),
                );
              }
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
                widget.pharmacy.name,
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
                    "${LocaleKeys.detail_district.tr()} ${widget.pharmacy.address}",
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
                  "${LocaleKeys.detail_phone.tr()} ${widget.pharmacy.phone}",
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