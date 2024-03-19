import 'package:flutter/material.dart';
import 'package:pokopedia/provider/transaction_provider.dart';
import 'package:provider/provider.dart';

import '../provider/user_provider.dart';
import '../styles/formatter.dart';
import '../styles/styles.dart';
import '../widgets/subtitle.dart';
import 'detail_product_page.dart';

class TransactionListPage extends StatefulWidget {
  const TransactionListPage({super.key});

  @override
  State<TransactionListPage> createState() => _TransactionListPageState();
}

class _TransactionListPageState extends State<TransactionListPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final String? accessToken =
          Provider.of<UserProvider>(context, listen: false).accessToken;
      Provider.of<TransactionProvider>(context, listen: false)
          .getTransactions(accessToken);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionProvider>(
        builder: (context, transactionState, child) {
      final transactions = transactionState.transactions;
      return Scaffold(
          body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              for (var transaction in transactions)
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
                                    DetailProduct(id: transaction.product.id)));
                      },
                      child: Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: const BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(20)),
                        ),
                        width: MediaQuery.of(context).size.width * 0.3,
                        height: MediaQuery.of(context).size.height,
                        child: Image.network(
                          transaction.product.productImages[0].url,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.59,
                      padding: const EdgeInsets.fromLTRB(18, 15, 10, 15),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Subtitle(
                                text: transaction.product.name, fontSize: 18),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  CurrencyFormat.convertToIdr(
                                      transaction.product.price, 0),
                                  style: TextStyle(color: navy(), fontSize: 15),
                                ),
                                Text(
                                  "x${transaction.productCount}",
                                  style: TextStyle(color: navy(), fontSize: 15),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  transaction.createdAt,
                                  style: TextStyle(color: navy(), fontSize: 15),
                                ),
                                Text(
                                  transaction.status,
                                  style: TextStyle(color: navy(), fontSize: 15),
                                ),
                              ],
                            ),
                          ]),
                    )
                  ]),
                ),
            ],
          ),
        ),
      ));
    });
  }
}
