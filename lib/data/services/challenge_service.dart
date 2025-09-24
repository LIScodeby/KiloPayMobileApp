// lib/data/services/challenge_service.dart
import '../models/challenge_model.dart';

class ChallengeService {
  // TODO: заменить на вызовы API
  Future<List<ChallengeModel>> getChallenges() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ChallengeModel.mock();
  }

  Future<bool> join(String challengeId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return true;
  }
}
