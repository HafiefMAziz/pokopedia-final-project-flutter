import 'dart:convert';
import 'package:http/http.dart';
import '../models/payment.dart';
import '../models/product.dart';
import '../models/transaction.dart';

class TransactionService {
  Future<List<Transaction>> getTransactions(accessToken) async {
    try {
      String url = "http://10.0.2.2:3000/transactions";
      Response response =
          await get(Uri.parse(url), headers: {'access_token': accessToken});
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final data = json["data"] as List;
        final transactions = data.map((transaction) {
          final images = transaction["product"]["productImages"].map((img) {
            return ProductImage(url: img["url"]);
          }).toList();
          final product = Product(
              id: transaction["product"]["id"],
              userId: transaction["product"]["userId"],
              name: transaction["product"]["name"],
              description: transaction["product"]["description"],
              stock: transaction["product"]["stock"],
              price: transaction["product"]["price"],
              unitSold: transaction["product"]["unitSold"],
              productImages: images,
              categories: []);
          return Transaction(
            id: transaction["id"],
            userId: transaction["userId"],
            productCount: transaction["productCount"],
            status: transaction["status"],
            product: product,
            payment: Payment(
                id: transaction["payment"]["id"],
                name: transaction["payment"]["name"]),
          );
        }).toList();
        return transactions;
      }
      throw "Error Get Transactions Services";
    } catch (e) {
      rethrow;
    }
  }

  Future checkout(
      accessToken, int productId, int productCount, int paymentId) async {
    try {
      String url = "http://10.0.2.2:3000/transactions/checkout";
      Response response = await post(Uri.parse(url), headers: {
        'access_token': accessToken
      }, body: {
        "productId": "$productId",
        "productCount": "$productCount",
        "paymentId": "$paymentId",
      });
      final json = jsonDecode(response.body);
      if (response.statusCode == 200) {
        final dataTransaction = json["dataTransaction"];
        final dataProduct = json["dataProduct"];
        final dataPayment = json["dataPayment"];
        final images = dataProduct["productImages"].map((img) {
          return ProductImage(url: img["url"]);
        }).toList();
        return Transaction(
          id: dataTransaction["id"],
          productCount: dataTransaction["productCount"],
          userId: dataTransaction["userId"],
          status: dataTransaction["status"],
          product: Product(
              id: dataProduct["id"],
              userId: dataProduct["userId"],
              name: dataProduct["name"],
              description: dataProduct["description"],
              stock: dataProduct["stock"],
              price: dataProduct["price"],
              unitSold: dataProduct["unitSold"],
              productImages: images,
              categories: []),
          payment: Payment(id: dataPayment["id"], name: dataPayment["name"]),
        );
      } else if (response.statusCode == 500) {
        return json;
      }
      throw "Error Adding to Transaction";
    } catch (e) {
      rethrow;
    }
  }
}
