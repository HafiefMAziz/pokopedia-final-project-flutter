import 'package:flutter/material.dart';
import 'package:pokopedia/widgets/loading.dart';
import 'package:pokopedia/widgets/poko_app_bar.dart';
import 'package:provider/provider.dart';

import '../provider/category_provider.dart';
import '../provider/user_provider.dart';
import '../styles/styles.dart';
import '../widgets/product_card.dart';
import '../widgets/subtitle.dart';

class CategoryProductPage extends StatefulWidget {
  const CategoryProductPage({super.key, required this.id});
  final int id;

  @override
  State<CategoryProductPage> createState() => _CategoryProductPageState();
}

class _CategoryProductPageState extends State<CategoryProductPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final String? accessToken =
          Provider.of<UserProvider>(context, listen: false).accessToken;
      Provider.of<CategoryProvider>(context, listen: false)
          .getCategoryById(accessToken, widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryProvider>(builder: (context, categoryState, child) {
      final category = categoryState.category;
      final loading = categoryState.loading;
      return Scaffold(
        appBar: PokoAppBar3(title: category!.name),
        body: loading
            ? const PokoLoading(size: 200)
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      color: lightBlue(),
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: MediaQuery.of(context).size.width,
                      child: Stack(
                        children: [
                          Positioned(
                            right: 0,
                            bottom: 0,
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: Image.asset("assets/images/login-chair.png",
                                fit: BoxFit.cover),
                          ),
                          Positioned(
                            left: 15,
                            bottom: 20,
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: Column(children: [
                              Subtitle(text: category.name, fontSize: 30),
                              Row(
                                children: [
                                  Subtitle(
                                      text: category.products.length.toString(),
                                      fontSize: 20),
                                  Text(" products",
                                      style: TextStyle(
                                          color: navy(), fontSize: 17))
                                ],
                              ),
                            ]),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      padding: EdgeInsets.all(15),
                      child: GridView.count(
                        physics: const NeverScrollableScrollPhysics(),
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 5,
                        crossAxisCount: 2,
                        childAspectRatio: (1 / 1.8),
                        children: <Widget>[
                          for (var product in category.products)
                            ProductCard(
                                id: product['id'],
                                name: product["name"],
                                price: product["price"],
                                imageUrl: product["productImages"][0]["url"],
                                )
                        ],
                      ),
                    )
                  ],
                ),
              ),
      );
    });
  }
}
