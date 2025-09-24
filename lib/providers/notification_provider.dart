// lib/providers/notification_provider.dart
import 'package:flutter/foundation.dart';
import '../data/services/notification_service.dart';

class NotificationProvider extends ChangeNotifier {
  final AppNotificationService _service = AppNotificationService();
  Map<String, bool> preferences = {'motivation': true, 'reminders': true, 'accruals': false};
  bool loading = false;

  Future<void> load() async {
    loading = true; notifyListeners();
    preferences = await _service.getPreferences();
    loading = false; notifyListeners();
  }

  Future<void> toggle(String key, bool value) async {
    preferences[key] = value;
    notifyListeners();
    await _service.setPreferences(preferences); // TODO: заменить мок на API
  }
}
