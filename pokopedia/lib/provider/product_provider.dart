import 'package:flutter/material.dart';
import 'package:pokopedia/service/product_services.dart';

import '../models/product.dart';

class ProductProvider extends ChangeNotifier {
  final ProductService _service = ProductService();
  List<Product> _products = [];
  List<Product> get products => _products;
  Product? _product;
  Product? get product => _product;
  bool loading = false;

  Future<void> getProducts(accessToken) async {
    loading = true;
    notifyListeners();
    final response = await _service.getProducts(accessToken);
    _products = response;
    await Future.delayed(const Duration(seconds: 1));
    loading = false;
    notifyListeners();
  }
  Future<void> getProductById(accessToken, id) async {
    loading = true;
    notifyListeners();
    final response = await _service.getProductById(accessToken, id);
    _product = response;
    // await Future.delayed(const Duration(seconds: 1));
    loading = false;
    notifyListeners();
  }
}
