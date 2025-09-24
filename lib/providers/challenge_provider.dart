// lib/providers/challenge_provider.dart
import 'package:flutter/foundation.dart';
import '../data/models/challenge_model.dart';
import '../data/services/challenge_service.dart';

class ChallengeProvider extends ChangeNotifier {
  final ChallengeService _service = ChallengeService();
  List<ChallengeModel> list = [];
  bool loading = false;

  Future<void> load() async {
    loading = true; notifyListeners();
    list = await _service.getChallenges();
    loading = false; notifyListeners();
  }

  Future<void> join(String id) async {
    if (await _service.join(id)) {
      await load();
    }
  }
}
