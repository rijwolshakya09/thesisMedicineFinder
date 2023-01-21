import 'package:json_annotation/json_annotation.dart';

part 'medicinebook.g.dart';

@JsonSerializable()
class MedicineBook {
  @JsonKey(name: '_id')
  String? id;
  String? medicine_name;
  String? medicine_price;
  String? medicine_image;
  String? medicine_description;
  String? status;
  String? pharmacyId;

  MedicineBook({
    this.id,
    this.medicine_name,
    this.medicine_price,
    this.medicine_image,
    this.medicine_description,
    this.status,
    this.pharmacyId,
  });

  factory MedicineBook.fromJson(Map<String, dynamic> json) {
    return _$MedicineBookFromJson(json);
  }

  Map<String, dynamic> toJson() => _$MedicineBookToJson(this);
}
