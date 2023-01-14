import 'package:json_annotation/json_annotation.dart';
part 'pharmacy.g.dart';

@JsonSerializable()
class Pharmacy {
  @JsonKey(name: '_id')
  String? id;
  String? first_name;
  String? last_name;
  String? pharmacy_name;
  String? description;
  String? address;
  double? lat;
  double? lng;
  String? contact_no;
  String? profile_pic;
  String? pharmacy_pic;
  String? email;

  Pharmacy({
    this.id,
    this.first_name,
    this.last_name,
    this.pharmacy_name,
    this.description,
    this.address,
    this.lat,
    this.lng,
    this.contact_no,
    this.profile_pic,
    this.pharmacy_pic,
    this.email,
  });

  factory Pharmacy.fromJson(Map<String, dynamic> json) =>
      _$PharmacyFromJson(json);

  Map<String, dynamic> toJson() => _$PharmacyToJson(this);
}
