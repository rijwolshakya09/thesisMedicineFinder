// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medicinebook.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MedicineBook _$MedicineBookFromJson(Map<String, dynamic> json) {
  return MedicineBook(
    id: json['_id'] as String?,
    medicine_name: json['medicine_name'] as String?,
    medicine_price: json['medicine_price'] as String?,
    medicine_image: json['medicine_image'] as String?,
    medicine_description: json['medicine_description'] as String?,
    status: json['status'] as String?,
    pharmacyId: json['pharmacyId'] as String?,
  );
}

Map<String, dynamic> _$MedicineBookToJson(MedicineBook instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'medicine_name': instance.medicine_name,
      'medicine_price': instance.medicine_price,
      'medicine_image': instance.medicine_image,
      'medicine_description': instance.medicine_description,
      'status': instance.status,
      'pharmacyId': instance.pharmacyId,
    };
