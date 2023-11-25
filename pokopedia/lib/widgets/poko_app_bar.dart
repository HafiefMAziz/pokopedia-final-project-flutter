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
      title: Text(title, style: TextStyle(color: navy(), fontSize: 20, fontWeight: FontWeight.w700),),
      centerTitle: true,
      );
  }
}

class CartIcon extends StatelessWidget {
  const CartIcon({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
        void cartButton() {
      print("Pencet");
    }
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: lightBlue(),
              border: Border.all(color: tropicalBlue(), width: 1.0),
              borderRadius:
                  const BorderRadius.all(Radius.circular(10.0))),
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
            child: const Center(
              child: Text(
                "2",
                style: TextStyle(
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
  }
}
