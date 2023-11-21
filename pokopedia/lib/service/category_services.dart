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
          );
        }).toList();
        return categories;
      }
      throw "Error Get Categories Services";
    } catch (e) {
      rethrow;
    }
  }
}
