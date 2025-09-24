// lib/data/services/profile_service.dart
import '../models/user_model.dart';

class ProfileService {
  // TODO: заменить на вызовы API
  Future<UserModel> getProfile() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return UserModel.mock();
  }

  Future<UserModel> updateProfile(UserModel updated) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return updated;
  }
}
