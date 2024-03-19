import 'dart:convert';
import 'package:http/http.dart';
import '../models/category.dart';

class CategoryService {
  Future<List<Category>> getCategories(accessToken) async {
    try {
      Response response = await get(
          Uri.parse("http://10.0.2.2:3000/categories"),
          headers: {'access_token': accessToken});
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final data = json["data"] as List;
        final categories = data.map((item) {
          return Category(
            id: item["id"],
            name: item["name"],
            baseColor: item["baseColor"],
            icon: item["icon"],
            products: item["products"],
          );
        }).toList();
        return categories;
      }
      throw "Error Get Categories Services";
    } catch (e) {
      rethrow;
    }
  }

  Future<Category> getCategoryById(accessToken, id) async {
    try {
      Response response = await get(
          Uri.parse("http://10.0.2.2:3000/categories/$id"),
          headers: {'access_token': accessToken});
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final data = json["data"];
        final category = Category(
            id: data["id"],
            name: data["name"],
            baseColor: data["baseColor"],
            icon: data["icon"],
            products: data["products"],
          );
        return category;
      }
      throw "Error Get Category Services";
    } catch (e) {
      rethrow;
    }
  }
}
