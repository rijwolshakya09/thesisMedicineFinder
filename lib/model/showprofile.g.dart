// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'showprofile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShowProfile _$ShowProfileFromJson(Map<String, dynamic> json) {
  return ShowProfile(
    id: json['_id'] as String?,
    first_name: json['first_name'] as String?,
    last_name: json['last_name'] as String?,
    address: json['address'] as String?,
    contact_no: json['contact_no'] as String?,
    gender: json['gender'] as String?,
    username: json['username'] as String?,
    email: json['email'] as String?,
    userType: json['userType'] as String?,
  );
}

Map<String, dynamic> _$ShowProfileToJson(ShowProfile instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'address': instance.address,
      'contact_no': instance.contact_no,
      'gender': instance.gender,
      'username': instance.username,
      'email': instance.email,
      'userType': instance.userType,
    };
