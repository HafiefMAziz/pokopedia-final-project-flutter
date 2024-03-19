import 'package:flutter/material.dart';
import '../service/transaction_services.dart';

import '../models/transaction.dart';

class TransactionProvider extends ChangeNotifier {
  final TransactionService _service = TransactionService();
  List<Transaction> _transactions = [];
  List<Transaction> get transactions => _transactions;
  List<Transaction> _currentTransactions = [];
  List<Transaction> get currentTransactions => _currentTransactions;
  Transaction? _transaction;
  Transaction? get transaction => _transaction;
  String? message;
  bool loading = false;

  Future<void> getTransactions(accessToken) async {
    loading = true;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 500));
    final response = await _service.getTransactions(accessToken);
    _transactions = response;
    loading = false;
    notifyListeners();
  }

  Future<void> checkout(
      accessToken, int productId, int productCount, int paymentId) async {
    loading = true;
    _currentTransactions.clear();
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 500));
    final response = await _service.checkout(
        accessToken, productId, productCount, paymentId);
    print(response);
    if (response is Transaction) {
      _transactions.add(response);
      _currentTransactions.add(response);
      message = "Your order has been placed!";
    } else if (response["error"] != null) {
      message = response["error"];
    }
    loading = false;
    notifyListeners();
  }
}
