import 'package:medicine_finder/api/medicine_api.dart';
import 'package:medicine_finder/response/medicine_response.dart';

class MedicineRepository {
  Future<MedicineResponse?> getMedicines() async {
    return MedicineAPI().getMedicines();
  }

  Future<MedicineResponse?> getMedByPharmacy(pharmacyId) async {
    return MedicineAPI().getMedByPharmacy(pharmacyId);
  }

  // Future<GuitarSingleResponse?> getSingleProducts(productId) async {
  //   return GuitarAPI().getSingleProducts(productId);
  // }
}
