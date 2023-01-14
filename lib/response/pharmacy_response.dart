// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';
import 'package:medicine_finder/model/pharmacy.dart';

part 'pharmacy_response.g.dart';

@JsonSerializable()
class PharmacyResponse {
  bool? success;
  List<Pharmacy>? data;

  PharmacyResponse({this.success, this.data});

  factory PharmacyResponse.fromJson(Map<String, dynamic> json) =>
      _$PharmacyResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PharmacyResponseToJson(this);
}
