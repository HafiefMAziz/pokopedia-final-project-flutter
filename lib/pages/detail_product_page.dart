import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:pokopedia/provider/user_provider.dart';
import 'package:pokopedia/styles/styles.dart';
import 'package:pokopedia/widgets/loading.dart';
import 'package:pokopedia/widgets/poko_app_bar.dart';
import 'package:pokopedia/widgets/subtitle.dart';
import 'package:provider/provider.dart';
import '../provider/cart_provider.dart';
import '../provider/product_provider.dart';
import '../widgets/alert_dialog.dart';
import '../widgets/product_card.dart';
import 'category_products_page.dart';

class DetailProduct extends StatefulWidget {
  const DetailProduct({super.key, required this.id});
  final int id;

  @override
  State<DetailProduct> createState() => _DetailProductState();
}

class _DetailProductState extends State<DetailProduct> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final String? accessToken =
          Provider.of<UserProvider>(context, listen: false).accessToken;
      Provider.of<ProductProvider>(context, listen: false)
          .getProducts(accessToken);
      Provider.of<ProductProvider>(context, listen: false)
          .getProductById(accessToken, widget.id);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<ProductProvider, CartProvider>(
        builder: (context, productState, cartState, child) {
      final products = productState.products;
      final product = productState.product;
      final loading = productState.loading;
      final cartMessage = cartState.message;

      addCart(int id) {
        final String? accessToken =
            Provider.of<UserProvider>(context, listen: false).accessToken;
        Provider.of<CartProvider>(context, listen: false)
            .addCarts(accessToken, id);
      }

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
      return product == null
          ? const PokoLoading(size: 300)
          : Scaffold(
              appBar: const PokoAppBar2(),
              bottomNavigationBar: GestureDetector(
                onTap: () => addCart(product.id),
                child: Container(
                  color: red(),
                  height: 60,
                  alignment: AlignmentDirectional.center,
                  child: Text(
                    "Add to Cart",
                    style: TextStyle(
                        color: lightBlue(),
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              body: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Container(
                        decoration: BoxDecoration(
                          color: lightBlue(),
                        ),
                        height: MediaQuery.of(context).size.height * 0.50,
                        width: MediaQuery.of(context).size.width,
                        child: loading
                            ? const PokoLoading(size: 300)
                            : Stack(children: [
                                CarouselSlider(
                                  options: CarouselOptions(
                                    enlargeCenterPage: true,
                                    viewportFraction: 1,
                                    height: MediaQuery.of(context).size.height,
                                  ),
                                  items: product.productImages.map((img) {
                                    return Builder(
                                      builder: (BuildContext context) {
                                        return Stack(
                                          children: [
                                            Image.network(
                                              img.url,
                                              fit: BoxFit.cover,
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }).toList(),
                                ),
                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 0, 0, 15),
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      CategoryProductPage(
                                                          id: product
                                                              .categories[0]
                                                              .id)));
                                        },
                                        child: Container(
                                            alignment: Alignment.center,
                                            padding: const EdgeInsets.fromLTRB(
                                                15, 10, 15, 10),
                                            decoration: BoxDecoration(
                                              color: navy(),
                                              shape: BoxShape.rectangle,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(30)),
                                            ),
                                            child: Row(
                                              children: [
                                                Image.network(
                                                  product.categories[0].icon,
                                                  fit: BoxFit.cover,
                                                  color: red(),
                                                  height: 30,
                                                ),
                                                Container(
                                                  margin:
                                                      const EdgeInsets.fromLTRB(
                                                          12, 0, 0, 0),
                                                  child: Text(
                                                    product.categories[0].name,
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18),
                                                  ),
                                                ),
                                              ],
                                            )),
                                      )),
                                ),
                              ])),
                    Container(
                      padding: const EdgeInsets.all(20),
                      color: Colors.white,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Subtitle(
                                  text: product.name.toString(), fontSize: 25),
                              IntrinsicHeight(
                                child: Row(
                                  children: [
                                    Container(
                                      margin:
                                          const EdgeInsets.fromLTRB(0, 0, 8, 0),
                                      child: Text(
                                        "Stock: ${product.stock}",
                                        style: TextStyle(
                                            color: navy(),
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    VerticalDivider(
                                      color: navy(),
                                      thickness: 1,
                                    ),
                                    Container(
                                      margin:
                                          const EdgeInsets.fromLTRB(8, 0, 0, 0),
                                      child: Text(
                                        "${product.unitSold} Unit Sold",
                                        style: TextStyle(
                                            color: navy(),
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Subtitle(text: "Rp. ${product.price}", fontSize: 25)
                        ],
                      ),
                    ),
                    Divider(
                      color: lightBlue(),
                      thickness: 15,
                    ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          const Subtitle(text: "Description", fontSize: 20),
                          Text(product.description.toString(),
                              style: TextStyle(color: navy(), fontSize: 15))
                        ],
                      ),
                    ),
                    Divider(
                      color: lightBlue(),
                      thickness: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Subtitle(
                            text: "Recomendations",
                            fontSize: 20,
                          ),
                          TextButton(
                            onPressed: () {
                              print("Navigate to All Products");
                            },
                            child: Text(
                              "View All >",
                              style: TextStyle(
                                  color: red(),
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                      height: 320,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return SizedBox(
                              width: 200,
                              child: ProductCard(
                                id: products[index].id,
                                name: products[index].name,
                                price: products[index].price,
                                imageUrl: products[index].productImages[0].url,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Divider(
                      color: lightBlue(),
                      thickness: 15,
                    ),
                  ],
                ),
              ),
            );
    });
  }
}
