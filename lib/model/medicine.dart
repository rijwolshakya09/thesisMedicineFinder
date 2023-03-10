import 'package:json_annotation/json_annotation.dart';
import 'package:medicine_finder/model/pharmacy.dart';

part 'medicine.g.dart';

@JsonSerializable()
class Medicine {
  @JsonKey(name: '_id')
  String? id;
  String? medicine_name;
  String? medicine_price;
  String? medicine_image;
  String? medicine_description;
  String? status;
  Pharmacy? pharmacyId;

  Medicine({
    this.id,
    this.medicine_name,
    this.medicine_price,
    this.medicine_image,
    this.medicine_description,
    this.status,
    this.pharmacyId,
  });

  factory Medicine.fromJson(Map<String, dynamic> json) {
    return _$MedicineFromJson(json);
  }

  Map<String, dynamic> toJson() => _$MedicineToJson(this);
}
