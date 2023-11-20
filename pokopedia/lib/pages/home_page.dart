import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:pokopedia/controllers/user_provider.dart';
import 'package:provider/provider.dart';
import '../styles/styles.dart';
import '../widgets/category_icon.dart';
import '../widgets/product_card.dart';
import '../widgets/subtitle.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List products = [];
  List categories = [];
  @override
  void initState() {
    getProducts();
    getCategories();
    super.initState();
  }

  void getProducts() async {
    try {
      Response response = await get(Uri.parse("http://10.0.2.2:3000/products"),
          headers: {
            'access_token':
                Provider.of<UserNotifier>(context, listen: false).accessToken
          });
      Map data = json.decode(response.body);
      setState(() {
        products = data["data"];
      });
    } catch (e) {
      print(e);
    }
  }

  void getCategories() async {
    try {
      Response response =
          await get(Uri.parse("http://10.0.2.2:3000/categories"), headers: {
        'access_token':
            Provider.of<UserNotifier>(context, listen: false).accessToken
      });
      Map data = json.decode(response.body);
      setState(() {
        categories = data["data"];
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Subtitle(
                  text: "Categories",
                  fontSize: 20,
                ),
                TextButton(
                  onPressed: () {
                    print("Navigate to All Categories");
                  },
                  child: Text(
                    "View All >",
                    style: TextStyle(
                        color: red(), decoration: TextDecoration.underline),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 80,
            margin: const EdgeInsets.fromLTRB(20, 0, 0, 10),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return CategoryIcon(
                  name: categories[index]["name"],
                  iconUrl: categories[index]["icon"],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Subtitle(
                  text: "Products",
                  fontSize: 20,
                ),
                TextButton(
                  onPressed: () {
                    print("Navigate to All Products");
                  },
                  child: Text(
                    "View All >",
                    style: TextStyle(
                        color: red(), decoration: TextDecoration.underline),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 300,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return ProductCard(
                    id: products[index]["id"],
                    name: products[index]["name"],
                    price: products[index]["price"],
                    imageUrl: products[index]["productImages"][0]["url"],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
