// lib/data/services/notification_service.dart
class AppNotificationService {
  // TODO: интеграция с FCM
  Future<Map<String, bool>> getPreferences() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return {
      'motivation': true,
      'reminders': true,
      'accruals': false,
    };
  }

  Future<bool> setPreferences(Map<String, bool> prefs) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return true;
  }
}
