// lib/providers/weight_provider.dart
import 'package:flutter/foundation.dart';
import '../data/models/weight_log_model.dart';
import '../data/services/weight_service.dart';

class WeightProvider extends ChangeNotifier {
  final WeightService _service = WeightService();
  List<WeightLogModel> history = [];
  String sessionCode = '';
  bool loading = false;

  Future<void> load() async {
    loading = true; notifyListeners();
    history = await _service.getHistory();
    sessionCode = await _service.generateSessionCode();
    loading = false; notifyListeners();
  }

  Future<bool> submit(double weight, {String? mediaPath}) async {
    loading = true; notifyListeners();
    final ok = await _service.submitWeight(weight: weight, mediaPath: mediaPath, code: sessionCode);
    if (ok) await load();
    loading = false; notifyListeners();
    return ok;
  }
}
