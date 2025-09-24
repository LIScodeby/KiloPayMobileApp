// lib/data/services/weight_service.dart
import '../models/weight_log_model.dart';

class WeightService {
  // TODO: заменить на вызовы API
  Future<List<WeightLogModel>> getHistory() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return WeightLogModel.mock();
  }

  Future<bool> submitWeight({required double weight, String? mediaPath, required String code}) async {
    await Future.delayed(const Duration(milliseconds: 800));
    return true;
  }

  Future<String> generateSessionCode() async {
    await Future.delayed(const Duration(milliseconds: 250));
    return 'KP-${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}';
  }
}
