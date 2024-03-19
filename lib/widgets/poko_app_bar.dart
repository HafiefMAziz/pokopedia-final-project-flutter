import 'package:provider/provider.dart';
import '../provider/cart_provider.dart';
import '../provider/page_provider.dart';
import '../provider/user_provider.dart';
import '../styles/styles.dart';
import 'package:flutter/material.dart';

class PokoAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PokoAppBar({Key? key}) : super(key: key);
  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      toolbarHeight: 80,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
              height: 25, child: Image.asset("assets/images/iconFont.png")),
          const CartIcon(),
        ],
      ),
    );
  }
}

class PokoAppBar2 extends StatelessWidget implements PreferredSizeWidget {
  const PokoAppBar2({Key? key}) : super(key: key);
  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: lightBlue(),
      elevation: 0,
      toolbarHeight: 80,
      leadingWidth: 70,
      leading: Padding(
        padding: const EdgeInsets.fromLTRB(20, 15, 0, 15),
        child: BackButton(
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
      title: const Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CartIcon(),
        ],
      ),
    );
  }
}

class PokoAppBar3 extends StatelessWidget implements PreferredSizeWidget {
  const PokoAppBar3({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: lightBlue(),
      elevation: 0,
      toolbarHeight: 80,
      leadingWidth: 70,
      leading: Padding(
        padding: const EdgeInsets.fromLTRB(20, 15, 0, 15),
        child: BackButton(
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
        title,
        style:
            TextStyle(color: navy(), fontSize: 20, fontWeight: FontWeight.w700),
      ),
      centerTitle: true,
    );
  }
}

class CartIcon extends StatefulWidget {
  const CartIcon({
    super.key,
  });

  @override
  State<CartIcon> createState() => _CartIconState();
}

class _CartIconState extends State<CartIcon> {
  @override
   @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final String? accessToken =
          Provider.of<UserProvider>(context, listen: false).accessToken;
      Provider.of<CartProvider>(context, listen: false).getCarts(accessToken);
    });
  }
  
  Widget build(BuildContext context) {
    @override
    void cartButton() {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Provider.of<PageProvider>(context, listen: false).pageIndex = 2;
      });
    }

    return Consumer<CartProvider>(builder: (context, cartState, child) {
      final carts = cartState.carts;
      final totalCarts = carts.length;
      return Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                color: lightBlue(),
                border: Border.all(color: tropicalBlue(), width: 1.0),
                borderRadius: const BorderRadius.all(Radius.circular(10.0))),
            child: IconButton(
                color: navy(),
                icon: const Icon(Icons.shopping_cart),
                onPressed: cartButton),
          ),
          Positioned(
            top: 4,
            right: 6,
            child: Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: red(),
              ),
              child: Center(
                child: Text(
                  "$totalCarts",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}
