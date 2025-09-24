// lib/providers/balance_provider.dart
import 'package:flutter/foundation.dart';
import '../data/models/tariff_model.dart';
import '../data/models/transaction_model.dart';
import '../data/services/balance_service.dart';

class BalanceProvider extends ChangeNotifier {
  final BalanceService _service = BalanceService();
  double balance = 0;
  TariffModel? tariff;
  List<TransactionModel> transactions = [];
  bool loading = false;

  Future<void> load() async {
    loading = true; notifyListeners();
    balance = await _service.getBalance();
    tariff = await _service.getTariff();
    transactions = await _service.getTransactions();
    loading = false; notifyListeners();
  }

  Future<bool> topUp(double amount) async {
    loading = true; notifyListeners();
    final ok = await _service.topUp(amount);
    if (ok) await load();
    loading = false; notifyListeners();
    return ok;
  }
}
