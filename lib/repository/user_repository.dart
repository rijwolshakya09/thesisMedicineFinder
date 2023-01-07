import 'package:medicine_finder/api/user_api.dart';
import 'package:medicine_finder/model/user.dart';

class UserRepository {
  Future<bool> registerUser(User user) async {
    return await UserAPI().registerUser(user);
  }

  Future<bool> login(String username, String password) {
    return UserAPI().login(username, password);
  }
}
