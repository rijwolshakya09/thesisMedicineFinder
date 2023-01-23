import 'dart:io';

import 'package:medicine_finder/api/profile_api.dart';
import 'package:medicine_finder/model/showprofile.dart';
import 'package:medicine_finder/response/profile_response.dart';

class ProfileRepository {
  Future<ProfileResponse?> getProfile() async {
    return ProfileAPI().getProfile();
  }

  Future<bool> updatePatientProfile(
      ShowProfile patientProfile, File? image) async {
    return await ProfileAPI().updatePatientProfile(patientProfile, image);
  }
}
