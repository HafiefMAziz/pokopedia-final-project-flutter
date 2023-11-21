import 'package:flutter/material.dart';
import 'package:pokopedia/controllers/user_provider.dart';
import 'package:pokopedia/provider/product_provider.dart';
import 'package:provider/provider.dart';
import '../provider/category_provider.dart';
import '../styles/styles.dart';
import '../widgets/category_icon.dart';
import '../widgets/product_card.dart';
import '../widgets/subtitle.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final String accessToken = Provider.of<UserNotifier>(context, listen: false).accessToken;
      Provider.of<ProductProvider>(context, listen: false).getProducts(accessToken);
      Provider.of<CategoryProvider>(context, listen: false).getCategories(accessToken);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer2<ProductProvider, CategoryProvider>(
          builder: (context, productState, categoryState, child) {
        final products = productState.products;
        final categories = categoryState.categories;
        final loadingProduct = productState.loading;
        final loadingCategory = categoryState.loading;
        return Column(
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
                  return loadingCategory
                      ? Container(
                          margin: const EdgeInsets.all(15),
                          child: LoadingAnimationWidget.twoRotatingArc(
                            color: navy(),
                            size: 80,
                          ),
                        )
                      : CategoryIcon(
                          name: categories[index].name,
                          iconUrl: categories[index].icon,
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
                    return loadingProduct
                        ? Container(
                            margin: const EdgeInsets.all(15),
                            child: LoadingAnimationWidget.twoRotatingArc(
                              color: navy(),
                              size: 80,
                            ),
                          )
                        : ProductCard(
                            id: products[index].id,
                            name: products[index].name,
                            price: products[index].price,
                            imageUrl: products[index].productImages[0].url,
                          );
                  },
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
