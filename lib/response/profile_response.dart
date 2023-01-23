import 'package:json_annotation/json_annotation.dart';
import 'package:medicine_finder/model/showprofile.dart';

part 'profile_response.g.dart';

@JsonSerializable()
class ProfileResponse {
  bool? success;
  ShowProfile? data;

  ProfileResponse({
    this.success,
    this.data,
  });

  factory ProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$ProfileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileResponseToJson(this);
}
