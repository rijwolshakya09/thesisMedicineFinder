// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pharmacy_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PharmacyResponse _$PharmacyResponseFromJson(Map<String, dynamic> json) =>
    PharmacyResponse(
      success: json['success'] as bool?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Pharmacy.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PharmacyResponseToJson(PharmacyResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
    };
