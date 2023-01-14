// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medicine_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MedicineResponse _$MedicineResponseFromJson(Map<String, dynamic> json) {
  return MedicineResponse(
    success: json['success'] as bool?,
    data: (json['data'] as List<dynamic>?)
        ?.map((e) => Medicine.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$MedicineResponseToJson(MedicineResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
    };
