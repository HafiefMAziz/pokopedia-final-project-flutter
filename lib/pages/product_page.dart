import 'package:flutter/material.dart';
import 'package:pokopedia/pages/category_products_page.dart';
import 'package:pokopedia/provider/category_provider.dart';
import 'package:pokopedia/styles/styles.dart';
import 'package:pokopedia/widgets/loading.dart';
import 'package:pokopedia/widgets/product_card.dart';
import 'package:provider/provider.dart';
import '../provider/cart_provider.dart';
import '../provider/product_provider.dart';
import '../provider/user_provider.dart';
import '../widgets/alert_dialog.dart';
import '../widgets/subtitle.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  String query = "";
  final fieldTextQuery = TextEditingController();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final String? accessToken =
          Provider.of<UserProvider>(context, listen: false).accessToken;
      Provider.of<ProductProvider>(context, listen: false)
          .getProducts(accessToken);
    });
  }

  void searchQuery(String text) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final String? accessToken =
          Provider.of<UserProvider>(context, listen: false).accessToken;
      Provider.of<ProductProvider>(context, listen: false)
          .getProducts(accessToken, text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer3<ProductProvider, CategoryProvider, CartProvider>(
        builder: (context, productState, categoryState, cartState, child) {
      final products = productState.products;
      final productsLoading = productState.loading;
      final categories = categoryState.categories;
      final categoriesLoading = categoryState.loading;
      final cartMessage = cartState.message;
      if (cartMessage != null) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertMessage(
                    titleMessage: "Message", contentMessage: cartMessage);
              });
          Provider.of<CartProvider>(context, listen: false).clearMessage();
        });
      }
      return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(children: [
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: TextFormField(
                  controller: fieldTextQuery,
                  onFieldSubmitted: (text) {
                    query = text;
                    searchQuery(text);
                  },
                  style: TextStyle(
                      color: navy(), fontSize: 18, fontWeight: FontWeight.w600),
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.search_rounded,
                      color: navy(),
                    ),
                    labelText: 'Search products ...',
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                  ),
                ),
              ),
              if (query == "")
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: const Subtitle(
                    text: "Categories",
                    fontSize: 20,
                  ),
                ),
              if (query == "")
                categoriesLoading
                    ? const PokoLoading(size: 100)
                    : Column(children: [
                        for (var cat in categories)
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          CategoryProductPage(id: cat.id)));
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
                                    child: Image.network(cat.icon, height: 40, color:navy(), fit: BoxFit.fitHeight)),
                                Container(
                                  height: 100,
                                  padding: const EdgeInsets.all(20),
                                  width: MediaQuery.of(context).size.width,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Subtitle(text: cat.name, fontSize: 20),
                                      Text("${cat.products.length} products",
                                          style: TextStyle(
                                              color: blueGreen(),
                                              fontSize: 15)),
                                    ],
                                  ),
                                ),
                              ]),
                            ),
                          ),
                      ]),
              Container(
                margin: const EdgeInsets.only(bottom: 20, top: 20),
                child: const Subtitle(
                  text: "Products",
                  fontSize: 20,
                ),
              ),
              productsLoading
                  ? const PokoLoading(size: 100)
                  : SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 1.1,
                      child: GridView.count(
                        physics: const NeverScrollableScrollPhysics(),
                        mainAxisSpacing: 8,
                        crossAxisCount: 2,
                        childAspectRatio: (1 / 1.7),
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
