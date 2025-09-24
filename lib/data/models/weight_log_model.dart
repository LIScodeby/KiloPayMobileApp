// lib/data/models/weight_log_model.dart
class WeightLogModel {
  final DateTime date;
  final double weight;
  final String? mediaUrl;
  final String status; // pending/approved/rejected

  WeightLogModel({required this.date, required this.weight, this.mediaUrl, required this.status});

  static List<WeightLogModel> mock() => [
        WeightLogModel(date: DateTime.now().subtract(const Duration(days: 9)), weight: 83.0, status: 'approved'),
        WeightLogModel(date: DateTime.now().subtract(const Duration(days: 6)), weight: 82.1, status: 'approved'),
        WeightLogModel(date: DateTime.now().subtract(const Duration(days: 4)), weight: 82.3, status: 'approved'),
      ];
}
