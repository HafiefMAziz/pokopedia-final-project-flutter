import 'package:flutter/material.dart';
import 'package:pokopedia/service/category_services.dart';

import '../models/category.dart';

class CategoryProvider extends ChangeNotifier {
  final CategoryService _service = CategoryService();
  List<Category> _categories = [];
  List<Category> get categories => _categories;
  Category? _category;
  Category? get category => _category;
  bool loading = false;

  Future<void> getCategories(accessToken) async {
    loading = true;
    notifyListeners();
    final response = await _service.getCategories(accessToken);
    _categories = response;
    await Future.delayed(const Duration(seconds: 1));
    loading = false;
    notifyListeners();
  }

  Future<void> getCategoryById(accessToken, id) async {
    loading = true;
    notifyListeners();
    final response = await _service.getCategoryById(accessToken, id);
    _category = response;
    loading = false;
    notifyListeners();
  }
}
