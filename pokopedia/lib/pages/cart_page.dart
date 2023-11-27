import 'package:flutter/material.dart';
import 'package:pokopedia/styles/formatter.dart';
import 'package:pokopedia/widgets/loading.dart';
import 'package:provider/provider.dart';
import '../styles/styles.dart';
import '../widgets/subtitle.dart';
import '../provider/cart_provider.dart';
import '../provider/user_provider.dart';
import 'detail_product_page.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final String? accessToken =
          Provider.of<UserProvider>(context, listen: false).accessToken;
      Provider.of<CartProvider>(context, listen: false).getCarts(accessToken);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<CartProvider, UserProvider>(
        builder: (context, cartState, userState, child) {
      final carts = cartState.carts;
      final loading = cartState.loading;
      final accessToken = userState.accessToken;
      return Scaffold(
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: Row(
                  children: [
                    Subtitle(text: carts.length.toString(), fontSize: 22),
                    Text(
                      " items",
                      style: TextStyle(color: navy(), fontSize: 18),
                    ),
                  ],
                ),
              ),
              loading
                  ? const PokoLoading(size: 100)
                  : Column(
                      children: [
                        for (var cart in carts)
                          Container(
                            height: 130,
                            margin: const EdgeInsets.only(bottom: 12),
                            decoration: BoxDecoration(
                              color: lightBlue(),
                              shape: BoxShape.rectangle,
                              border: Border.all(color: tropicalBlue()),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            child: Stack(
                              children: [
                                Row(children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailProduct(
                                                      id: cart.product.id)));
                                    },
                                    child: Container(
                                      clipBehavior: Clip.antiAlias,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.horizontal(
                                            left: Radius.circular(20)),
                                      ),
                                      width: MediaQuery.of(context).size.width *
                                          0.35,
                                      height:
                                          MediaQuery.of(context).size.height,
                                      child: Image.network(
                                        cart.product.productImages[0].url,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Subtitle(
                                              text: cart.product.name,
                                              fontSize: 20),
                                          Text(
                                            CurrencyFormat.convertToIdr(
                                                cart.product.price, 0),
                                            style: TextStyle(
                                                color: navy(), fontSize: 18),
                                          ),
                                        ]),
                                  )
                                ]),
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      color: red(),
                                      borderRadius: const BorderRadius.only( topRight: Radius.circular(20), bottomLeft: Radius.circular(20))
                                    ),
                                    child: IconButton(
                                      onPressed: () {
                                        print("delete");
                                      },
                                      icon: const Icon(Icons.delete_rounded, color: Colors.white),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Row(
                                    children: [
                                      IconButton(
                                          iconSize: 35,
                                          onPressed: cart.productCount <
                                                  cart.product.stock
                                              ? () async {
                                                  if (!loading) {
                                                    await cartState
                                                        .increaseCount(
                                                            accessToken,
                                                            cart.id);
                                                  }
                                                }
                                              : null,
                                          icon:
                                              const Icon(Icons.add_box_rounded),
                                          color: red()),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Subtitle(
                                            text: cart.productCount.toString(),
                                            fontSize: 20),
                                      ),
                                      IconButton(
                                        iconSize: 35,
                                        onPressed: cart.productCount > 1
                                            ? () async {
                                                if (!loading) {
                                                  await cartState.decreaseCount(
                                                      accessToken, cart.id);
                                                }
                                              }
                                            : null,
                                        icon: const Icon(Icons
                                            .indeterminate_check_box_rounded),
                                        color: red(),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                      ],
                    ),
            ],
          ),
        ),
      );
    });
  }
}
