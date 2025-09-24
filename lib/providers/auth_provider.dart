// lib/providers/auth_provider.dart
import 'package:flutter/foundation.dart';
import '../data/services/auth_service.dart';
import '../data/local_storage/preferences.dart';
import '../data/models/user_model.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _auth = AuthService();
  UserModel? currentUser;
  bool loading = false;

  Future<bool> sendCode(String phone) async {
    loading = true; notifyListeners();
    final ok = await _auth.sendSmsCode(phone);
    loading = false; notifyListeners();
    return ok;
  }

  Future<bool> verifyCode(String phone, String code) async {
    loading = true; notifyListeners();
    final ok = await _auth.verifySmsCode(phone, code);
    loading = false; notifyListeners();
    return ok;
  }

  Future<bool> login(String phone, String password) async {
    loading = true; notifyListeners();
    final user = await _auth.login(phone, password);
    currentUser = user;
    await Preferences.saveToken('mock.jwt.token'); // TODO: заменить на реальный токен
    loading = false; notifyListeners();
    return true;
  }

  Future<bool> register(String phone, String password, {String? email}) async {
    loading = true; notifyListeners();
    currentUser = await _auth.register(phone: phone, password: password, email: email);
    await Preferences.saveToken('mock.jwt.token'); // TODO
    loading = false; notifyListeners();
    return true;
  }

  Future<void> logout() async {
    currentUser = null;
    await Preferences.clear();
    notifyListeners();
  }
}
