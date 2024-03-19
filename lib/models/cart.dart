import '../models/product.dart';

class Cart {
  final int id;
  final int productId;
  int productCount;
  final String createdAt;
  final Product product;
  int totalPrice;

  Cart({
    required this.id,
    required this.productId,
    required this.productCount,
    required this.createdAt,
    required this.product,
    required this.totalPrice,
  });
}
