import 'package:pokopedia/pages/detail_product_page.dart';
import 'package:pokopedia/styles/formatter.dart';
import 'package:provider/provider.dart';
import '../provider/cart_provider.dart';
import '../provider/user_provider.dart';
import '../widgets/subtitle.dart';
import 'package:flutter/material.dart';

import '../styles/styles.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
  });
  final int id;
  final String name;
  final int price;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    addCart(int id) {
      final String? accessToken =
          Provider.of<UserProvider>(context, listen: false).accessToken;
      Provider.of<CartProvider>(context, listen: false)
          .addCarts(accessToken, id);
    }

    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: tropicalBlue(),
        ),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      child: Stack(children: [
        Column(
          children: [
            Expanded(
              flex: 6,
              child: SizedBox(
                width: double.infinity,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailProduct(id: id)));
                  },
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                  color: lightBlue(),
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(12),
                  ),
                ),
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Subtitle(
                        text: name,
                        fontSize: 20,
                      ),
                      Subtitle(
                        text: CurrencyFormat.convertToIdr(price, 0),
                        fontSize: 17,
                      ),
                    ]),
              ),
            ),
          ],
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: IconButton(
            onPressed: () => addCart(id),
            icon: Icon(
              Icons.add_box_rounded,
              color: red(),
              size: 40,
            ),
          ),
        ),
      ]),
    );
  }
}
