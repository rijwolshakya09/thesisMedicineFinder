// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookmed.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookMedicine _$BookMedicineFromJson(Map<String, dynamic> json) {
  return BookMedicine(
    id: json['_id'] as String?,
    medicine: json['medicine'] == null
        ? null
        : MedicineBook.fromJson(json['medicine'] as Map<String, dynamic>),
    userId: json['userId'] == null
        ? null
        : User.fromJson(json['userId'] as Map<String, dynamic>),
    quantity: json['quantity'] as int?,
    total_price: json['total_price'] as int?,
    status: json['status'] as String?,
  );
}

Map<String, dynamic> _$BookMedicineToJson(BookMedicine instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'medicine': instance.medicine,
      'userId': instance.userId,
      'quantity': instance.quantity,
      'total_price': instance.total_price,
      'status': instance.status,
    };
