import 'package:flutter/material.dart';
import 'package:pharmacy_app/models/pharmacy_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:pharmacy_app/services/pharmacy_service.dart';
import 'package:pharmacy_app/views/detail_page.dart';

class ResultPage extends StatefulWidget {
  final String city;
  final String dist;

  const ResultPage({super.key, required this.city, required this.dist});

  @override
  State<ResultPage> createState() => _ResultPageState();
}


class _ResultPageState extends State<ResultPage> {
  final PharmacyService _pharmacyService = PharmacyService();
  late Future<List<Pharmacy>?> _futurePharmacies;

  void initState() {
    super.initState();
    _futurePharmacies = _pharmacyService.fetchPharmacies(widget.city, widget.dist);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        body: FutureBuilder<List<Pharmacy>?>(
        future: _futurePharmacies,
        builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }


          if (snapshot.hasError || snapshot.data == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 60),
                  const SizedBox(height: 10),
                  Text(
                    'network_api_error'.tr(),
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            );
          }

          final pharmacies = snapshot.data!;

          if (pharmacies.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.search_off, color: Colors.amber, size: 60),
                  const SizedBox(height: 10),
                  Text('warning_not_found'.tr(), style: const TextStyle(fontSize: 18)),
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount: pharmacies.length,
            itemBuilder: (context, index) {
              final pharmacy = pharmacies[index];
              return ListTile(
                leading: Image.asset('assets/images/pharmacy-icon.png', width: 40, height: 40),
                title: Text(pharmacy.name),
                subtitle: Text(pharmacy.dist),
                trailing: ElevatedButton(
                  onPressed: () {
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
          );
        },
      ),
    );
  }
}
