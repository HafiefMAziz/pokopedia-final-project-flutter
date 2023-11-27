import 'package:flutter/material.dart';
import '../service/cart_services.dart';

import '../models/cart.dart';

class CartProvider extends ChangeNotifier {
  final CartService _service = CartService();
  List<Cart> _carts = [];
  List<Cart> get carts => _carts;
  Cart? _cart;
  Cart? get cart => _cart;
  String? message;
  bool loading = false;

  Future<void> getCarts(accessToken) async {
    loading = true;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 500));
    final response = await _service.getCarts(accessToken);
    _carts = response;
    loading = false;
    notifyListeners();
  }

  Future<void> addCarts(accessToken, productId) async {
    loading = true;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 500));
    final response = await _service.addCart(accessToken, productId);
    print(response);
    if (response is Cart) {
      _carts.add(response);
      message = "Success adding to your Carts";
    } else if (response["error"] != null) {
      message = response["error"];
    }
    loading = false;
    notifyListeners();
  }

  Future<void> deleteCarts(accessToken, int id) async {
    loading = true;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 500));
    final response = await _service.deleteCart(accessToken, id);
    message = response;
    _carts.removeWhere((cart) => cart.id == id);
    loading = false;
    notifyListeners();
  }

  void clearMessage() {
    message = null;
    message = null;
    notifyListeners();
  }

  Future<void> increaseCount(accessToken, int id) async {
    loading = true;
    notifyListeners();
    final selectedCart = _carts.where((cart) => cart.id == id).first;
    final increasedCount = selectedCart.productCount + 1;
    final response =
        await _service.updateCount(accessToken, id, increasedCount);
    _carts = _carts.map((cart) {
      if (cart == selectedCart) {
        cart.productCount += 1;
      }
      return cart;
    }).toList();
    loading = false;
    notifyListeners();
  }

  Future<void> decreaseCount(accessToken, int id) async {
    loading = true;
    notifyListeners();
    final selectedCart = _carts.where((cart) => cart.id == id).first;
    final decreasedCount = selectedCart.productCount - 1;
    final response =
        await _service.updateCount(accessToken, id, decreasedCount);
    _carts = _carts.map((cart) {
      if (cart == selectedCart) {
        cart.productCount -= 1;
      }
      return cart;
    }).toList();
    loading = false;
    notifyListeners();
  }

  // Future<void> getCartById(accessToken, id) async {
  //   loading = true;
  //   notifyListeners();
  //   await Future.delayed(const Duration(seconds: 1));
  //   final response = await _service.getCartById(accessToken, id);
  //   _cart = response;
  //   loading = false;
  //   notifyListeners();
  // }
}
