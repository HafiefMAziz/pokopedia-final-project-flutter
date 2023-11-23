import 'dart:convert';
import 'package:http/http.dart';
import '../models/product.dart';

class ProductService {
  Future<List<Product>> getProducts(accessToken, [queryName]) async {
    try {
      String url = "http://10.0.2.2:3000/products";
      if (queryName != null) {
        url = "http://10.0.2.2:3000/products?name=$queryName";
      }
      Response response =
          await get(Uri.parse(url), headers: {'access_token': accessToken});
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final data = json["data"] as List;
        final products = data.map((item) {
          final img = item["productImages"].map((i) {
            return ProductImage(url: i["url"]);
          }).toList();
          final cat = item["categories"].map((i) {
            return ProductCategory(
                id: i["id"],
                name: i["name"],
                icon: i["icon"],
                baseColor: i["baseColor"]);
          }).toList();
          return Product(
            id: item["id"],
            userId: item["userId"],
            name: item["name"],
            description: item["description"],
            stock: item["stock"],
            price: item["price"],
            unitSold: item["unitSold"],
            productImages: img,
            categories: cat,
          );
        }).toList();
        return products;
      }
      throw "Error Get Produproducts Services";
    } catch (e) {
      rethrow;
    }
  }

  Future<Product> getProductById(accessToken, id) async {
    try {
      Response response = await get(
          Uri.parse("http://10.0.2.2:3000/products/$id"),
          headers: {'access_token': accessToken});
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final data = json["data"];
        final img = data["productImages"].map((i) {
          return ProductImage(url: i["url"]);
        }).toList();
        final cat = data["categories"].map((i) {
          return ProductCategory(
              id: i["id"],
              name: i["name"],
              icon: i["icon"],
              baseColor: i["baseColor"]);
        }).toList();
        final product = Product(
          id: data["id"],
          userId: data["userId"],
          name: data["name"],
          description: data["description"],
          stock: data["stock"],
          price: data["price"],
          unitSold: data["unitSold"],
          productImages: img,
          categories: cat,
        );
        return product;
      }
      throw "Error Get Produproducts Services";
    } catch (e) {
      rethrow;
    }
  }
}
