import 'package:flutter/material.dart';
import 'package:pharmacy_app/services/pharmacy_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:pharmacy_app/views/result_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _selectedCity = 'Adana';
  final List<String> _cities = [
    'Adana', 'Adıyaman', 'Afyonkarahisar', 'Ağrı', 'Amasya', 'Ankara', 'Antalya', 'Artvin', 'Aydın', 'Balıkesir',
    'Bilecik', 'Bingöl', 'Bitlis', 'Bolu', 'Burdur', 'Bursa', 'Çanakkale', 'Çankırı', 'Çorum', 'Denizli',
    'Diyarbakır', 'Edirne', 'Elazığ', 'Erzincan', 'Erzurum', 'Eskişehir', 'Gaziantep', 'Giresun', 'Gümüşhane', 'Hakkari',
    'Hatay', 'Isparta', 'Mersin', 'İstanbul', 'İzmir', 'Kars', 'Kastamonu', 'Kayseri', 'Kırklareli', 'Kırşehir',
    'Kocaeli', 'Konya', 'Kütahya', 'Malatya', 'Manisa', 'Kahramanmaraş', 'Mardin', 'Muğla', 'Muş', 'Nevşehir',
    'Niğde', 'Ordu', 'Rize', 'Sakarya', 'Samsun', 'Siirt', 'Sinop', 'Sivas', 'Tekirdağ', 'Tokat',
    'Trabzon', 'Tunceli', 'Şanlıurfa', 'Uşak', 'Van', 'Yozgat', 'Zonguldak', 'Aksaray', 'Bayburt', 'Karaman',
    'Kırıkkale', 'Batman', 'Şırnak', 'Bartın', 'Ardahan', 'Iğdır', 'Yalova', 'Karabük', 'Kilis', 'Osmaniye', 'Düzce',
  ];

  String? _selectedDistrict;
  List<dynamic> _districts = [];
  final PharmacyService _pharmacyService = PharmacyService();

  
  Widget _buildDecorationBox() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
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
              style: TextStyle(color: Colors.red.shade900, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
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
            Text('home_page'.tr(), style: const TextStyle(fontSize: 30)),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
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
              
              _buildDecorationBox(),
              
              const SizedBox(height: 20),
              
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: DropdownButtonFormField<String>(
                        hint: Text('select_city'.tr()),
                        value: _selectedCity,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        ),
                        items: _cities.map((city) => DropdownMenuItem(value: city, child: Text(city))).toList(),
                        onChanged: (newValue) async {
                          if (newValue != null) {
                            setState(() {
                              _selectedDistrict = null;
                              _selectedCity = newValue;
                              _districts = [];
                            });
                            var districtsList = await _pharmacyService.getDistricts(newValue);
                            setState(() {
                              _districts = districtsList;
                            });
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
                        value: _districts.any((element) => element['text'] == _selectedDistrict) ? _selectedDistrict : null,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        ),
                        items: _districts.map((district) {
                          return DropdownMenuItem<String>(
                            value: district['text'],
                            child: Text(district['text']),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          if (newValue != null) {
                            setState(() {
                              _selectedDistrict = newValue;
                            });
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      if (_selectedDistrict != null && _selectedDistrict!.isNotEmpty) {
                        // Direkt sayfaya paslıyoruz, FutureBuilder orada hallediyor
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ResultPage(
                              city: _selectedCity,
                              dist: _selectedDistrict!,
                            ),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('warning_select_district'.tr())),
                        );
                      }
                    },
                    child: const Icon(Icons.search),
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