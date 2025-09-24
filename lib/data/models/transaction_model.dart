// lib/data/models/transaction_model.dart
class TransactionModel {
  final String id;
  final String type; // Пополнение/Начисление/Вывод
  final double amount;
  final DateTime date;

  TransactionModel({
    required this.id,
    required this.type,
    required this.amount,
    required this.date,
  });

  static List<TransactionModel> mockList() => [
        TransactionModel(id: 't1', type: 'Пополнение', amount: 2000, date: DateTime.now().subtract(const Duration(days: 5))),
        TransactionModel(id: 't2', type: 'Начисление', amount: 100, date: DateTime.now().subtract(const Duration(days: 3))),
        TransactionModel(id: 't3', type: 'Вывод', amount: -500, date: DateTime.now().subtract(const Duration(days: 1))),
      ];
}
