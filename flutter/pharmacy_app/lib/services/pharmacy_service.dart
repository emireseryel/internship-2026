import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/pharmacy_model.dart';

class PharmacyService {
  final _dio = Dio();

  Future<List<Pharmacy>?> fetchPharmacies(String city) async {
    try {
      String dynamicUrl = 'https://api.collectapi.com/health/dutyPharmacy?il=$city';
      Map<String, dynamic> headers = {
        "content-type": "application/json",
        "authorization": "apikey ${dotenv.env['COLLECT_API_KEY']}",
      };

      Response response = await _dio.get(
        dynamicUrl,
        options: Options(headers: headers),
      );

      if (response.statusCode == 200) {
        List<dynamic> data = response.data['result'];

        var pharmacies = <Pharmacy>[];
        for (var item in data){
          Pharmacy pharmacy = Pharmacy.fromJson(item);
          pharmacies.add(pharmacy);
        } 

        return pharmacies;
      }
    } catch (e) {
      print("Hata oluştu: $e");
      return null;
    }

    return null;
  }
}
