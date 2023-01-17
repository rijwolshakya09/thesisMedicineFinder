import 'package:json_annotation/json_annotation.dart';
import 'package:medicine_finder/model/medicine.dart';
import 'package:medicine_finder/model/user.dart';

part 'bookmed.g.dart';

@JsonSerializable()
class BookMedicine {
  @JsonKey(name: '_id')
  String? id;
  Medicine? medicine;
  User? userId;
  int? quantity;
  int? total_price;
  String? status;

  BookMedicine({
    this.id,
    this.medicine,
    this.userId,
    this.quantity,
    this.total_price,
    this.status,
  });

  factory BookMedicine.fromJson(Map<String, dynamic> json) {
    return _$BookMedicineFromJson(json);
  }

  Map<String, dynamic> toJson() => _$BookMedicineToJson(this);
}
