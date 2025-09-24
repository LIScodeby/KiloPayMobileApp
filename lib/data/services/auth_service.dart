// lib/data/services/auth_service.dart
import '../models/user_model.dart';

class AuthService {
  // TODO: заменить на реальные запросы
  Future<bool> sendSmsCode(String phone) async {
    await Future.delayed(const Duration(milliseconds: 600));
    return true; // Мок
  }

  Future<bool> verifySmsCode(String phone, String code) async {
    await Future.delayed(const Duration(milliseconds: 600));
    return code == '123456'; // Мок: 123456 — верный код
  }

  Future<UserModel> login(String phone, String password) async {
    await Future.delayed(const Duration(milliseconds: 700));
    return UserModel.mock();
  }

  Future<UserModel> register({
    required String phone,
    required String password,
    String? email,
  }) async {
    await Future.delayed(const Duration(milliseconds: 800));
    return UserModel.mock();
  }
}
