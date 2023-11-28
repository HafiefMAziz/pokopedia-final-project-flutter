import 'package:flutter/material.dart';
import 'package:pokopedia/main.dart';
import 'package:pokopedia/provider/transaction_provider.dart';
import 'package:pokopedia/styles/formatter.dart';
import 'package:pokopedia/widgets/loading.dart';
import 'package:provider/provider.dart';

import '../styles/styles.dart';

class OrderSuccessPage extends StatefulWidget {
  const OrderSuccessPage({super.key, required this.total});
  final int total;

  @override
  State<OrderSuccessPage> createState() => _OrderSuccessPageState();
}

class _OrderSuccessPageState extends State<OrderSuccessPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionProvider>(
        builder: (context, transactionState, child) {
      final currentTransactions = transactionState.currentTransactions;
      final loading = transactionState.loading;
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 80,
          leadingWidth: 70,
          leading: Padding(
            padding: const EdgeInsets.fromLTRB(20, 15, 0, 15),
            child: CloseButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => const MainPage()));
              },
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(lightBlue()),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(color: blueGreen()),
                  ),
                ),
              ),
            ),
          ),
          title: Text(
            "Success Order",
            style: TextStyle(
                color: navy(), fontSize: 20, fontWeight: FontWeight.w700),
          ),
          centerTitle: true,
        ),
        body: loading
            ? const PokoLoading(size: 100)
            : currentTransactions.isNotEmpty
                ? SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            height: MediaQuery.of(context).size.height * 0.5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 230,
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 30),
                                  child: Image.asset(
                                    "assets/images/happy-shopping.png",
                                    fit: BoxFit.fitHeight,
                                  ),
                                ),
                                Text(
                                  "Your order has been placed!",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: navy(),
                                      fontSize: 22,
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  "The order will be forwarded  the seller. \nPlease check status of your order in the \ntransaction list.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: navy(), fontSize: 14),
                                )
                              ],
                            ),
                          ),
                          Table(
                            border: TableBorder.all(
                                color: tropicalBlue(),
                                borderRadius: BorderRadius.circular(10)),
                            children: [
                              TableRow(children: [
                                Container(
                                  color: lightBlue(),
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Order Detail",
                                    style: TextStyle(
                                        color: navy(),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ]),
                              for (var transaction in currentTransactions)
                                TableRow(children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          transaction.product.name,
                                          style: TextStyle(
                                              color: navy(), fontSize: 15),
                                        ),
                                        Text(
                                          CurrencyFormat.convertToIdr(
                                              transaction.product.price, 0),
                                          style: TextStyle(
                                              color: navy(), fontSize: 15),
                                        ),
                                      ],
                                    ),
                                  ),
                                ]),
                              TableRow(children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Amount Paid",
                                        style: TextStyle(
                                            color: navy(), fontSize: 15),
                                      ),
                                      Text(
                                        CurrencyFormat.convertToIdr(
                                            widget.total, 0),
                                        style: TextStyle(
                                            color: navy(), fontSize: 15),
                                      ),
                                    ],
                                  ),
                                ),
                              ]),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                : const PokoLoading(size: 100),
      );
    });
  }
}
