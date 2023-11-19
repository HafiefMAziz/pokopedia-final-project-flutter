import 'dart:convert';
import 'package:http/http.dart';

import '../models/product_model.dart';

Future<ProductModel?> getProducts(accessToken) async {
  ProductModel? result;
  try {
    Response response = await get(Uri.parse("http://10.0.2.2:3000/products/1"),
        headers: {'access_token': accessToken});
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      result = ProductModel.fromJson(data);
    } else {
      print("Error getProducts");
    }
  } catch (e) {
    print(e);
  }
  return result;
}
