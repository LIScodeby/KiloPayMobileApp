// lib/providers/profile_provider.dart
import 'package:flutter/foundation.dart';
import '../data/models/user_model.dart';
import '../data/services/profile_service.dart';

class ProfileProvider extends ChangeNotifier {
  final ProfileService _service = ProfileService();
  UserModel? profile;
  bool loading = false;

  Future<void> load() async {
    loading = true; notifyListeners();
    profile = await _service.getProfile();
    loading = false; notifyListeners();
  }

  Future<void> update(UserModel updated) async {
    loading = true; notifyListeners();
    profile = await _service.updateProfile(updated);
    loading = false; notifyListeners();
  }
}
