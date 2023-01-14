// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pharmacy.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pharmacy _$PharmacyFromJson(Map<String, dynamic> json) {
  return Pharmacy(
    id: json['_id'] as String?,
    first_name: json['first_name'] as String?,
    last_name: json['last_name'] as String?,
    pharmacy_name: json['pharmacy_name'] as String?,
    description: json['description'] as String?,
    address: json['address'] as String?,
    lat: (json['lat'] as num?)?.toDouble(),
    lng: (json['lng'] as num?)?.toDouble(),
    contact_no: json['contact_no'] as String?,
    profile_pic: json['profile_pic'] as String?,
    pharmacy_pic: json['pharmacy_pic'] as String?,
    email: json['email'] as String?,
  );
}

Map<String, dynamic> _$PharmacyToJson(Pharmacy instance) => <String, dynamic>{
      '_id': instance.id,
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'pharmacy_name': instance.pharmacy_name,
      'description': instance.description,
      'address': instance.address,
      'lat': instance.lat,
      'lng': instance.lng,
      'contact_no': instance.contact_no,
      'profile_pic': instance.profile_pic,
      'pharmacy_pic': instance.pharmacy_pic,
      'email': instance.email,
    };
