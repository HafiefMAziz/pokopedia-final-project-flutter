import 'dart:convert';
import 'package:http/http.dart';
import '../models/product.dart';
import '../models/cart.dart';

class CartService {
  Future<List<Cart>> getCarts(accessToken) async {
    try {
      String url = "http://10.0.2.2:3000/carts";
      Response response =
          await get(Uri.parse(url), headers: {'access_token': accessToken});
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final data = json["data"] as List;
        final carts = data.map((cart) {
          final images = cart["product"]["productImages"].map((img) {
            return ProductImage(url: img["url"]);
          }).toList();
          final product = Product(
              id: cart["product"]["id"],
              userId: cart["product"]["userId"],
              name: cart["product"]["name"],
              description: cart["product"]["description"],
              stock: cart["product"]["stock"],
              price: cart["product"]["price"],
              unitSold: cart["product"]["unitSold"],
              productImages: images,
              categories: []);
          return Cart(
              id: cart["id"],
              productId: cart["productId"],
              productCount: cart["productCount"],
              createdAt: cart["createdAt"],
              product: product);
        }).toList();
        return carts;
      }
      throw "Error Get Carts Services";
    } catch (e) {
      rethrow;
    }
  }

  Future addCart(accessToken, int productId) async {
    try {
      String url = "http://10.0.2.2:3000/carts/add";
      Response response = await post(Uri.parse(url), headers: {
        'access_token': accessToken
      }, body: {
        "productId": "$productId",
        "productCount": "1",
      });
      final json = jsonDecode(response.body);
      if (response.statusCode == 200) {
        final dataCart = json["data"]["newCart"];
        final dataProduct = json["data"]["productCart"];
        final img = dataProduct["productImages"].map((i) {
          return ProductImage(url: i["url"]);
        }).toList();
        return Cart(
          id: dataCart["id"],
          productId: dataCart["productId"],
          productCount: dataCart["productCount"],
          createdAt: dataCart["createdAt"],
          product: Product(
            id: dataProduct["id"],
            userId: dataProduct["userId"],
            name: dataProduct["name"],
            description: dataProduct["description"],
            stock: dataProduct["stock"],
            price: dataProduct["price"],
            unitSold: dataProduct["unitSold"],
            productImages: img,
            categories: [],
          ),
        );
      } 
      else if (response.statusCode == 500) {
        return json;
      }
      throw "Error Adding to Cart";
    } catch (e) {
      rethrow;
    }
  }

  Future deleteCart(accessToken, int id) async {
    try {
      String url = "http://10.0.2.2:3000/carts/delete/$id";
      Response response = await delete(Uri.parse(url), headers: {
        'access_token': accessToken
      });
      final json = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return json["message"];
      } 
      else if (response.statusCode == 500) {
        return json["error"];
      }
      throw "Error Deleting to Cart";
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateCount(accessToken, id, int productCount) async {
    try {
      String url = "http://10.0.2.2:3000/carts/updateCount/$id";
      Response response = await put(Uri.parse(url),
          headers: {'access_token': accessToken},
          body: {"productCount": "$productCount"});
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return json;
      }
      throw "Error Update Count Cart Services";
    } catch (e) {
      rethrow;
    }
  }
}
