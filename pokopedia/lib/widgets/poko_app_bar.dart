import '../styles/styles.dart';
import 'package:flutter/material.dart';

class PokoAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PokoAppBar({Key? key}) : super(key: key);
  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    void cartButton() {
      print("Pencet");
    }

    return AppBar(
      backgroundColor: lightBlue(),
      elevation: 0,
      toolbarHeight: 80,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
              height: 25, child: Image.asset("assets/images/iconFont.png")),
          Container(
              decoration: BoxDecoration(
                  border: Border.all(color: navy(), width: 1.0),
                  borderRadius:
                      const BorderRadius.all(Radius.circular(10.0))),
              child: IconButton.outlined(
                  color: navy(),
                  icon: const Icon(Icons.shopping_cart),
                  onPressed: cartButton)),
        ],
      ),
    );
  }
}
