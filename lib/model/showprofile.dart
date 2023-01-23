import 'package:json_annotation/json_annotation.dart';
part 'showprofile.g.dart';

@JsonSerializable()
class ShowProfile {
  @JsonKey(name: '_id')
  String? id;
  String? first_name;
  String? last_name;
  String? address;
  String? contact_no;
  String? gender;
  String? username;
  String? email;
  // String? profile_pic;
  // String? password;
  String? userType;

  ShowProfile({
    this.id,
    this.first_name,
    this.last_name,
    this.address,
    this.contact_no,
    this.gender,
    this.username,
    // this.password,
    this.email,
    // this.profile_pic,
    this.userType,
  });

  factory ShowProfile.fromJson(Map<String, dynamic> json) =>
      _$ShowProfileFromJson(json);

  Map<String, dynamic> toJson() => _$ShowProfileToJson(this);
}
