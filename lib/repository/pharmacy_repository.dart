import 'package:medicine_finder/api/pharmacy_api.dart';
import 'package:medicine_finder/model/pharmacy.dart';
import 'package:medicine_finder/response/pharmacy_response.dart';

class CategoryRepository {
  Future<List<Pharmacy?>> loadpharmacy() {
    return PharmacyAPI().loadpharmacy();
  }

  Future<PharmacyResponse?> getPharmacy() async {
    return PharmacyAPI().getPharmacy();
  }
}
