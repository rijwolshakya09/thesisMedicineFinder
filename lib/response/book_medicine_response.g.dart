// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_medicine_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookMedicineResponse _$BookMedicineResponseFromJson(Map<String, dynamic> json) {
  return BookMedicineResponse(
    success: json['success'] as bool?,
    data: (json['data'] as List<dynamic>?)
        ?.map((e) => BookMedicine.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$BookMedicineResponseToJson(
        BookMedicineResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
    };
