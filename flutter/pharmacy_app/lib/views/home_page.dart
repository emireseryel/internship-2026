import 'package:flutter/material.dart';
import '../services/pharmacy_service.dart';
import '../models/pharmacy_model.dart';
import 'package:easy_localization/easy_localization.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _selectedCity = 'Adana';

  final List<String> _cities = [
  'Adana', 'Adıyaman', 'Afyonkarahisar', 'Ağrı', 'Amasya', 'Ankara', 'Antalya', 'Artvin',
  'Aydın', 'Balıkesir', 'Bilecik', 'Bingöl', 'Bitlis', 'Bolu', 'Burdur', 'Bursa', 'Çanakkale',
  'Çankırı', 'Çorum', 'Denizli', 'Diyarbakır', 'Edirne', 'Elazığ', 'Erzincan', 'Erzurum',
  'Eskişehir', 'Gaziantep', 'Giresun', 'Gümüşhane', 'Hakkari', 'Hatay', 'Isparta', 'Mersin',
  'İstanbul', 'İzmir', 'Kars', 'Kastamonu', 'Kayseri', 'Kırklareli', 'Kırşehir', 'Kocaeli',
  'Konya', 'Kütahya', 'Malatya', 'Manisa', 'Kahramanmaraş', 'Mardin', 'Muğla', 'Muş',
  'Nevşehir', 'Niğde', 'Ordu', 'Rize', 'Sakarya', 'Samsun', 'Siirt', 'Sinop', 'Sivas',
  'Tekirdağ', 'Tokat', 'Trabzon', 'Tunceli', 'Şanlıurfa', 'Uşak', 'Van', 'Yozgat', 'Zonguldak',
  'Aksaray', 'Bayburt', 'Karaman', 'Kırıkkale', 'Batman', 'Şırnak', 'Bartın', 'Ardahan',
  'Iğdır', 'Yalova', 'Karabük', 'Kilis', 'Osmaniye', 'Düzce'
];

  final PharmacyService _pharmacyService = PharmacyService();
  List<Pharmacy>? _pharmacies;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _fetchData(String cityName) async {
    setState(() {
      _isLoading = true;
    });

    final result = await _pharmacyService.fetchPharmacies(cityName);

    setState(() {
      _pharmacies = result;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('app_title'.tr())),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    initialValue: _selectedCity,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                    ),
                    items: _cities.map((String city) {
                      return DropdownMenuItem<String>(
                        value: city,
                        child: Text(city),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          _selectedCity = newValue;
                        });
                      }
                    },
                  ),
                ),

                ElevatedButton(
                  onPressed: () {
                    _fetchData(_selectedCity);
                  },
                  child: const Icon(Icons.search),
                ),
              ],
            ),
          ),

          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _pharmacies == null || _pharmacies!.isEmpty
                ? Center(child: Text('no_pharmacy'.tr()))
                : ListView.builder(
                    itemCount: _pharmacies!.length,
                    itemBuilder: (context, index) {
                      final pharmacy = _pharmacies![index];
                      return ListTile(
                        title: Text(pharmacy.name),
                        subtitle: Text(
                          '${pharmacy.dist} - ${pharmacy.address}',
                        ),
                        trailing: Text(pharmacy.phone),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
