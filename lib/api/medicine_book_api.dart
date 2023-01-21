import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:medicine_finder/model/bookmed.dart';
import 'package:medicine_finder/response/book_medicine_response.dart';
import 'package:medicine_finder/utils/url.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'http_services.dart';

class BookMedicineAPI {
  Future<bool> bookMedicine(
      medicine, int? quantity, int? totalPrice, String? status) async {
    bool isAdded = false;
    try {
      Response response;
      var url = baseUrl + medicineBookUrl;
      var dio = HttpServices().getDioInstance();
      response = await dio.post(
        url,
        data: {
          "medicine": medicine,
          "quantity": quantity,
          "total_price": totalPrice,
          "status": status,
        },
        options: Options(
          headers: {
            HttpHeaders.authorizationHeader: "Bearer $token",
          },
        ),
      );

      debugPrint(response.toString());

      if (response.statusCode == 201) {
        return isAdded = true;
      }
    } catch (e) {
      throw Exception(e);
    }
    return isAdded;
  }

  Future<List<BookMedicine?>> getBookedMedicine() async {
    List<BookMedicine?> bookedMedicineResponseList = [];
    Response response;
    String? url = baseUrl + bookedMedicineUrl;
    Dio dio = HttpServices().getDioInstance();

    Future.delayed(const Duration(seconds: 2), () {});
    BookMedicineResponse? bookMedicineResponse;
    debugPrint(token);
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("token");
      response = await dio.get(
        url,
        options: Options(
          headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
        ),
      );
      debugPrint(response.data!.toString());
      if (response.statusCode == 201) {
        bookMedicineResponse = BookMedicineResponse.fromJson(response.data);
        for (var data in bookMedicineResponse.data!) {
          bookedMedicineResponseList.add(
            BookMedicine(
              id: data.id,
              medicine: data.medicine,
              userId: data.userId,
              quantity: data.quantity,
              total_price: data.total_price,
              status: data.status,
            ),
          );
        }
      } else {
        bookMedicineResponse = null;
      }
    } catch (e) {
      // throw Exception(e);
      debugPrint("error.........$e");
    }
    return bookedMedicineResponseList;
  }

  Future<bool> deleteBookedMed(String bookMedId) async {
    bool isDeleted = false;
    String url = baseUrl + bookedMedicineDelUrl;
    Dio dio = HttpServices().getDioInstance();

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("token");
      Response response = await dio.delete(
        url + bookMedId,
        options: Options(
          headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
        ),
      );
      // debugPrint(response.toString());
      if (response.statusCode == 201) {
        return true;
      }
    } catch (e) {
      debugPrint("Error: ${e.toString()}");
    }
    return isDeleted;
  }
}
