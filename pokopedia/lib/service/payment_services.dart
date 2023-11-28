import 'dart:convert';
import 'package:http/http.dart';
import '../models/product.dart';
import '../models/payment.dart';

class PaymentService {
  Future<List<Payment>> getPayments(accessToken) async {
    try {
      String url = "http://10.0.2.2:3000/payments";
      Response response =
          await get(Uri.parse(url), headers: {'access_token': accessToken});
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final data = json["data"] as List;
        final payments = data.map((payment) {
          return Payment(
            id: payment["id"],
            name: payment["name"],
          );
        }).toList();
        return payments;
      }
      throw "Error Get Payments Services";
    } catch (e) {
      rethrow;
    }
  }
}
