import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:medicine_finder/model/showprofile.dart';
import 'package:medicine_finder/response/profile_response.dart';
import 'package:medicine_finder/utils/url.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'http_services.dart';

class ProfileAPI {
  Future<ProfileResponse?> getProfile() async {
    Future.delayed(const Duration(seconds: 2), () {});
    ProfileResponse? profileResponse;
    // debugPrint("saddddddd" + token!);
    try {
      var dio = HttpServices().getDioInstance();
      Response response = await dio.get(
        profileUrl,
        options: Options(
          headers: {
            HttpHeaders.authorizationHeader: "Bearer $token",
          },
        ),
      );
      if (response.statusCode == 201) {
        debugPrint(response.data.toString());
        profileResponse = ProfileResponse.fromJson(response.data);
      } else {
        profileResponse = null;
      }
    } catch (e) {
      throw Exception(e);
    }
    return profileResponse;
  }

  Future<bool> updatePatientProfile(
      ShowProfile patientProfile, File? image) async {
    debugPrint(patientProfile.first_name);
    bool isUpdated = false;
    FormData data = FormData.fromMap({
      "full_name": patientProfile.first_name,
      "last_name": patientProfile.last_name,
      "address": patientProfile.address,
      "contact_no": patientProfile.contact_no,
      "gender": patientProfile.gender,
      "username": patientProfile.username,
      "email": patientProfile.email,
    });
    // debugPrint(data.toString());
    try {
      var url = baseUrl + updateprofileUrl;
      var dio = HttpServices().getDioInstance();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("token");
      var response = await dio.put(
        url,
        data: data,
        options: Options(
          headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
        ),
      );
      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      debugPrint("Error updating patient profile: $e");
    }

    return isUpdated;
  }
}
