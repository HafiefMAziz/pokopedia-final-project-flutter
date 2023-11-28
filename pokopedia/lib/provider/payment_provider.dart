import 'package:flutter/material.dart';
import '../service/payment_services.dart';

import '../models/payment.dart';

class PaymentProvider extends ChangeNotifier {
  final PaymentService _service = PaymentService();
  List<Payment> _payments = [];
  List<Payment> get payments => _payments;
  Payment? _payment;
  Payment? get payment => _payment;
  bool loading = false;

  Future<void> getPayments(accessToken) async {
    loading = true;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 500));
    final response = await _service.getPayments(accessToken);
    _payments = response;
    loading = false;
    notifyListeners();
  }

}
