import 'package:json_annotation/json_annotation.dart';
import 'package:medicine_finder/model/bookmed.dart';

part 'book_medicine_response.g.dart';

@JsonSerializable()
class BookMedicineResponse {
  bool? success;
  List<BookMedicine>? data;

  BookMedicineResponse({
    this.success,
    this.data,
  });

  factory BookMedicineResponse.fromJson(Map<String, dynamic> json) =>
      _$BookMedicineResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BookMedicineResponseToJson(this);
}
