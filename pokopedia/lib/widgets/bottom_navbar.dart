import '../controllers/main_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../styles/styles.dart';
import 'bottom_nav_icon.dart';

class BottomNavbar extends StatelessWidget {
  const BottomNavbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<MainNotifier>(builder: (context, mainNotifier, child) {
      return Container(
        decoration: BoxDecoration(
          color: lightBlue(),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BottomNavIcon(
                onTap: () {
                  mainNotifier.pageIndex = 0;
                },
                icon: Icons.home,
                iconColor: mainNotifier.pageIndex == 0 ? red() : blueGreen(),
              ),
              BottomNavIcon(
                onTap: () {
                  mainNotifier.pageIndex = 1;
                },
                icon: Icons.chair_rounded,
                iconColor: mainNotifier.pageIndex == 1 ? red() : blueGreen(),
              ),
              BottomNavIcon(
                onTap: () {
                  mainNotifier.pageIndex = 2;
                },
                icon: Icons.shopping_bag,
                iconColor: mainNotifier.pageIndex == 2 ? red() : blueGreen(),
              ),
              BottomNavIcon(
                onTap: () {
                  mainNotifier.pageIndex = 3;
                },
                icon: Icons.list_rounded,
                iconColor: mainNotifier.pageIndex == 3 ? red() : blueGreen(),
              ),
              BottomNavIcon(
                onTap: () {
                  mainNotifier.pageIndex = 4;
                },
                icon: Icons.person,
                iconColor: mainNotifier.pageIndex == 4 ? red() : blueGreen(),
              ),
            ],
          ),
        ),
      );
    });
  }
}
