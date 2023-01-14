// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';
import 'package:medicine_finder/model/medicine.dart';

part 'medicine_response.g.dart';

@JsonSerializable()
class MedicineResponse {
  bool? success;
  List<Medicine>? data;

  MedicineResponse({this.success, this.data});

  factory MedicineResponse.fromJson(Map<String, dynamic> json) =>
      _$MedicineResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MedicineResponseToJson(this);
}
