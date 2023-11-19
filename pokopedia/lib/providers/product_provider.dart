import 'package:flutter/cupertino.dart';
import 'package:pokopedia/models/product_model.dart';

import '../services/api.dart';

class ProductProvider extends ChangeNotifier {
  ProductModel? products;
  bool loading = false;
  String accessToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwidXNlcm5hbWUiOiJhZG1pbjEyMyIsImVtYWlsIjoiYWRtaW4xMjNAbWFpbC5jb20iLCJmdWxsbmFtZSI6IlN1cGVyIEFkbWluIiwiYXZhdGFyIjoiaHR0cHM6Ly9iYW5uZXIyLmNsZWFucG5nLmNvbS8yMDE4MDQwMi9vancva2lzc3BuZy11bml0ZWQtc3RhdGVzLWF2YXRhci1vcmdhbml6YXRpb24taW5mb3JtYXRpb24tdXNlci1hdmF0YXItNWFjMjA4MDRhNjJiNTguODY3MzYyMDIxNTIyNjY1NDc2NjgwNi5qcGciLCJhZGRyZXNzIjoiZGlhbW5hIGtqYWprYSIsImlzQWRtaW4iOnRydWUsImlhdCI6MTcwMDEyOTUxOH0.cTOxDoNCWxSIXD8C_MbCTCcX-qnVc7mURiYzBCAFu8w";

  getProductsData() async {
    loading = true;
    products = (await getProducts(accessToken))!;
    loading = false;
    
    notifyListeners();
  }
}