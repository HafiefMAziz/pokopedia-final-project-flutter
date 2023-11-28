import 'package:flutter/material.dart';
import 'package:pokopedia/models/cart.dart';
import 'package:pokopedia/provider/cart_provider.dart';
import 'package:pokopedia/provider/user_provider.dart';
import 'package:pokopedia/styles/styles.dart';
import 'package:pokopedia/widgets/loading.dart';
import 'package:pokopedia/widgets/poko_app_bar.dart';
import 'package:pokopedia/widgets/subtitle.dart';
import 'package:provider/provider.dart';

import '../provider/payment_provider.dart';
import '../provider/transaction_provider.dart';
import '../styles/formatter.dart';
import 'detail_product_page.dart';
import 'order_success_Page.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  int selectedPaymentId = 1;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final String? accessToken =
          Provider.of<UserProvider>(context, listen: false).accessToken;
      Provider.of<PaymentProvider>(context, listen: false)
          .getPayments(accessToken);
    });
  }

  order(List<Cart> carts, int paymentId, int total) {
    for (var cart in carts) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        final String? accessToken =
            Provider.of<UserProvider>(context, listen: false).accessToken;
        Provider.of<TransactionProvider>(context, listen: false).checkout(
            accessToken, cart.productId, cart.productCount, paymentId);
      });
    }
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => OrderSuccessPage(total: total)));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer3<CartProvider, UserProvider, PaymentProvider>(
        builder: (context, cartState, userState, paymentState, child) {
      final user = userState.user;
      final carts = cartState.carts;
      final payments = paymentState.payments;
      final userLoading = userState.loading;
      final cartsLoading = cartState.loading;
      final paymentsLoading = paymentState.loading;
      final totalPrices = carts.map((cart) => cart.totalPrice);
      final subtotal = totalPrices.fold(0, (prev, i) => prev + i);
      const shipmentPrice = 20000;
      final total = subtotal + shipmentPrice;
      return Scaffold(
        bottomNavigationBar: TextButton(
          onPressed: () => order(carts, selectedPaymentId, total),
          style: ButtonStyle(
              padding: const MaterialStatePropertyAll(
                  EdgeInsets.symmetric(vertical: 15)),
              backgroundColor: MaterialStatePropertyAll(red()),
              shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero))),
          child: Text(
            "Order",
            style: TextStyle(
                color: lightBlue(), fontSize: 20, fontWeight: FontWeight.w500),
          ),
        ),
        appBar: const PokoAppBar3(title: "Checkout"),
        body: userLoading & cartsLoading & paymentsLoading
            ? const PokoLoading(size: 100)
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          const Subtitle(
                              text: "Delivery Adrress", fontSize: 20),
                          Card(
                            color: lightBlue(),
                            elevation: 0,
                            margin: const EdgeInsets.only(top: 10, bottom: 10),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: blue(),
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 80,
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(right: 10),
                                    child: SizedBox(
                                      child: Image.asset(
                                        "assets/images/home.png",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Text(user!.address,
                                      style: TextStyle(
                                          color: navy(),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: lightBlue(),
                      thickness: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              child:
                                  const Subtitle(text: "Items", fontSize: 20)),
                          Column(
                            children: [
                              for (var cart in carts)
                                Container(
                                  height: 100,
                                  margin: const EdgeInsets.only(bottom: 12),
                                  decoration: BoxDecoration(
                                    color: lightBlue(),
                                    shape: BoxShape.rectangle,
                                    border: Border.all(color: tropicalBlue()),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(15),
                                    ),
                                  ),
                                  child: Row(children: [
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
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.3,
                                        height:
                                            MediaQuery.of(context).size.height,
                                        child: Image.network(
                                          cart.product.productImages[0].url,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.fromLTRB(
                                          18, 15, 0, 15),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Subtitle(
                                                text: cart.product.name,
                                                fontSize: 18),
                                            Text(
                                              CurrencyFormat.convertToIdr(
                                                  cart.product.price, 0),
                                              style: TextStyle(
                                                  color: navy(), fontSize: 15),
                                            ),
                                            Text(
                                              "x${cart.productCount}",
                                              style: TextStyle(
                                                  color: navy(), fontSize: 15),
                                            ),
                                          ]),
                                    )
                                  ]),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: lightBlue(),
                      thickness: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          const Subtitle(text: "Payments", fontSize: 20),
                          Container(
                            alignment: Alignment.centerLeft,
                            margin: const EdgeInsets.symmetric(vertical: 15),
                            child: DropdownMenu(
                                initialSelection: payments.first.id,
                                textStyle: TextStyle(color: navy()),
                                onSelected: (paymentId) {
                                  setState(() {
                                    selectedPaymentId = paymentId!;
                                  });
                                },
                                dropdownMenuEntries: payments.map((payment) {
                                  return DropdownMenuEntry(
                                      value: payment.id, label: payment.name);
                                }).toList()),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: lightBlue(),
                      thickness: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          const Subtitle(text: "Order Summary", fontSize: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Subtotal",
                                style: TextStyle(color: navy(), fontSize: 15),
                              ),
                              Text(
                                CurrencyFormat.convertToIdr(subtotal, 0),
                                style: TextStyle(color: navy(), fontSize: 15),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Shipment",
                                style: TextStyle(color: navy(), fontSize: 15),
                              ),
                              Text(
                                CurrencyFormat.convertToIdr(shipmentPrice, 0),
                                style: TextStyle(color: navy(), fontSize: 15),
                              ),
                            ],
                          ),
                          Divider(
                            color: navy(),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Subtitle(
                                text: "Total",
                                fontSize: 20,
                              ),
                              Subtitle(
                                text: CurrencyFormat.convertToIdr(total, 0),
                                fontSize: 20,
                              ),
                            ],
                          ),
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
