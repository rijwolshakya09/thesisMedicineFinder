import 'package:medicine_finder/api/medicine_book_api.dart';

class BookedMedicineRepository {
  // Future<List<AddToCart?>> getCart() async {
  //   return AddToCartAPI().getCart();
  // }

  Future<bool> bookMedicine(
      medicine, int? quantity, int? totalPrice, String? status) async {
    return BookMedicineAPI()
        .bookMedicine(medicine, quantity, totalPrice, status);
  }

  // Future<bool> deleteCart(String cartId) async {
  //   return AddToCartAPI().deleteCart(cartId);
  // }
}
