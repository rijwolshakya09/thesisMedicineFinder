import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/material.dart';
import 'package:medicine_finder/model/pharmacy.dart';
import 'package:medicine_finder/response/pharmacy_response.dart';

import '../utils/url.dart';
import 'http_services.dart';

class PharmacyAPI {
  Future<List<Pharmacy?>> loadpharmacy() async {
    List<Pharmacy?> pharmacyList = [];
    Response response;
    var url = baseUrl + pharmacyUrl;
    var dio = HttpServices().getDioInstance();
    try {
      response = await dio.get(
        url,
      );

      if (response.statusCode == 201) {
        PharmacyResponse pharmacyResponse =
            PharmacyResponse.fromJson(response.data);

        for (var data in pharmacyResponse.data!) {
          pharmacyList.add(
            Pharmacy(
              id: data.id,
              pharmacy_name: data.pharmacy_name,
              description: data.description,
              pharmacy_pic: data.pharmacy_pic,
              lat: data.lat,
              lng: data.lng,
              address: data.address,
            ),
          );
        }
      }
    } catch (e) {
      debugPrint('Failed to get pharmacy $e');
    }

    return pharmacyList;
  }

  Future<PharmacyResponse?> getPharmacy() async {
    Future.delayed(const Duration(seconds: 2), () {});
    PharmacyResponse? pharmacyResponse;
    try {
      var dio = HttpServices().getDioInstance();
      dio.interceptors
          .add(DioCacheManager(CacheConfig(baseUrl: baseUrl)).interceptor);
      Response response = await dio.get(
        pharmacyUrl,
        options: buildCacheOptions(const Duration(days: 7)),
      );
      // debugPrint("........${response.data!}");
      if (response.statusCode == 201) {
        pharmacyResponse = PharmacyResponse.fromJson(response.data);
      } else {
        pharmacyResponse = null;
      }
    } catch (e) {
      throw Exception(e);
    }
    return pharmacyResponse;
  }
}
