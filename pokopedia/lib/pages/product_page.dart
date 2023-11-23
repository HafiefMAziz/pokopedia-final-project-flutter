import 'package:flutter/material.dart';
import 'package:pokopedia/pages/category_products_page.dart';
import 'package:pokopedia/provider/category_provider.dart';
import 'package:pokopedia/styles/styles.dart';
import 'package:pokopedia/widgets/product_card.dart';
import 'package:provider/provider.dart';
import '../provider/product_provider.dart';
import '../widgets/subtitle.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<ProductProvider, CategoryProvider>(
        builder: (context, productState, categoryState, child) {
      final products = productState.products;
      final categories = categoryState.categories;
      return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(children: [
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: const Subtitle(
                  text: "Categories",
                  fontSize: 20,
                ),
              ),
              Column(children: [
                for (var cat in categories)
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryProductPage(id: cat.id)));
                    },
                    child: Card(
                      margin: const EdgeInsets.only(bottom: 15),
                      color: lightBlue(),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide(color: tropicalBlue()),
                      ),
                      child: Stack(children: [
                        Positioned(
                            right: 15,
                            bottom: 0,
                            child: Image.network(cat.icon)),
                        Container(
                          height: 120,
                          padding: const EdgeInsets.all(20),
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Subtitle(text: cat.name, fontSize: 20),
                              Text("${cat.products.length} products",
                                  style: TextStyle(
                                      color: blueGreen(), fontSize: 15)),
                            ],
                          ),
                        ),
                      ]),
                    ),
                  ),
              ]),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 10,
                  crossAxisCount: 2,
                  childAspectRatio: (1/1.8),
                  children: <Widget>[
                    for (var product in products)
                      SizedBox(
                        child: ProductCard(
                            id: product.id,
                            name: product.name,
                            price: product.price,
                            imageUrl: product.productImages[0].url),
                      )
                  ],
                ),
              )
            ]),
          ),
        ),
      );
    });
  }
}
