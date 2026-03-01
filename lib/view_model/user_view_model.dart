import 'package:nike_shoes_app/repository/user_data_repo.dart';

class UserViewModel {
  final UserDataRepo userRepo = UserDataRepo();
  Future<bool> isAdmin() async {
    return await userRepo.isAdminAccessAllowed();
  }

  Future<Map<String, dynamic>?> getUserData() async {
    return await userRepo.fetchUserData();
  }
}
