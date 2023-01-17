import 'package:medicine_finder/api/medicine_book_api.dart';
import 'package:medicine_finder/model/bookmed.dart';

class BookedMedicineRepository {
  Future<List<BookMedicine?>> getBookedMedicine() async {
    return BookMedicineAPI().getBookedMedicine();
  }

  Future<bool> bookMedicine(
      medicine, int? quantity, int? totalPrice, String? status) async {
    return BookMedicineAPI()
        .bookMedicine(medicine, quantity, totalPrice, status);
  }

  Future<bool> deleteBookedMed(String bookMedId) async {
    return BookMedicineAPI().deleteBookedMed(bookMedId);
  }
}
