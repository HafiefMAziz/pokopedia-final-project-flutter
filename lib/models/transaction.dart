import 'payment.dart';
import 'product.dart';

class Transaction {
  final int id;
  final int userId;
  final Product product;
  final int productCount;
  final Payment payment;
  final String status;
  final String createdAt;

  Transaction({
    required this.id,
    required this.userId,
    required this.product,
    required this.productCount,
    required this.payment,
    required this.status,
    required this.createdAt,
  });
}
