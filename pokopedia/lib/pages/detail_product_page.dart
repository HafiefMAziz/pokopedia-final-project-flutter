import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:pokopedia/widgets/poko_app_bar.dart';
import 'package:provider/provider.dart';
import '../controllers/user_provider.dart';

class DetailProduct extends StatefulWidget {
  const DetailProduct({super.key, required this.id});
  final int id;

  @override
  State<DetailProduct> createState() => _DetailProductState();
}

class _DetailProductState extends State<DetailProduct> {
  Object product = {};
  @override
  void initState() {
    getProduct();
    super.initState();
  }

  void getProduct() async {
    try {
      Response response = await get(
          Uri.parse("http://10.0.2.2:3000/products/${widget.id}"),
          headers: {
            'access_token':
                Provider.of<UserNotifier>(context, listen: false).accessToken
          });
      Map data = json.decode(response.body);
      setState(() {
        product = data["data"];
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PokoAppBar(),
      body: Text(product.toString()),
    );
  }
}
