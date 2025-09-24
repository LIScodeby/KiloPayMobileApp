// lib/data/services/balance_service.dart
import '../models/tariff_model.dart';
import '../models/transaction_model.dart';

class BalanceService {
  // TODO: заменить на вызовы API
  Future<double> getBalance() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return 3200; // Мок
  }

  Future<List<TransactionModel>> getTransactions() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return TransactionModel.mockList();
  }

  Future<TariffModel> getTariff() async {
    await Future.delayed(const Duration(milliseconds: 450));
    return TariffModel.mockBasic();
  }

  Future<bool> topUp(double amount) async {
    await Future.delayed(const Duration(milliseconds: 700));
    return true;
  }
}
