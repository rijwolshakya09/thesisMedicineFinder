import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/cupertino.dart';
import 'package:medicine_finder/response/medicine_response.dart';
import 'package:medicine_finder/utils/url.dart';

// ignore: depend_on_referenced_packages

import 'http_services.dart';

class MedicineAPI {
  Future<MedicineResponse?> getMedicines() async {
    Future.delayed(const Duration(seconds: 2), () {});
    MedicineResponse? medicineResponse;
    try {
      var dio = HttpServices().getDioInstance();
      dio.interceptors
          .add(DioCacheManager(CacheConfig(baseUrl: baseUrl)).interceptor);
      Response response = await dio.get(
        medicineUrl,
        options: buildCacheOptions(const Duration(days: 7)),
      );
      debugPrint("MedicineAPI........${response.data!}");
      if (response.statusCode == 200) {
        medicineResponse = MedicineResponse.fromJson(response.data);
      } else {
        medicineResponse = null;
      }
    } catch (e) {
      throw Exception(e);
    }
    return medicineResponse;
  }

  Future<MedicineResponse?> getMedByPharmacy(pharmacyId) async {
    Future.delayed(const Duration(seconds: 2), () {});
    MedicineResponse? medicineResponse;
    try {
      var dio = HttpServices().getDioInstance();
      Response response = await dio.get(medicineByPharmacyUrl + pharmacyId);
      if (response.statusCode == 200) {
        debugPrint(response.data.toString());
        medicineResponse = MedicineResponse.fromJson(response.data);
      } else {
        medicineResponse = null;
      }
    } catch (e) {
      throw Exception(e);
    }
    return medicineResponse;
  }
}
