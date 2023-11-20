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
          borderRadius: const BorderRadius.vertical(top: Radius.elliptical(30, 30)),
          color: lightBlue(),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BottomNavIcon(
                onTap: () {
                  mainNotifier.pageIndex = 0;
                },
                icon: Icons.home_rounded,
                selected: mainNotifier.pageIndex == 0 ? true : false,
              ),
              BottomNavIcon(
                onTap: () {
                  mainNotifier.pageIndex = 1;
                },
                icon: Icons.category_rounded,
                selected: mainNotifier.pageIndex == 1 ? true : false,
              ),
              BottomNavIcon(
                onTap: () {
                  mainNotifier.pageIndex = 2;
                },
                icon: Icons.shopping_bag,
                selected: mainNotifier.pageIndex == 2 ? true : false,
              ),
              BottomNavIcon(
                onTap: () {
                  mainNotifier.pageIndex = 3;
                },
                icon: Icons.list_rounded,
                selected: mainNotifier.pageIndex == 3 ? true : false,
              ),
              BottomNavIcon(
                onTap: () {
                  mainNotifier.pageIndex = 4;
                },
                icon: Icons.person,
                selected: mainNotifier.pageIndex == 4 ? true : false,
              ),
            ],
          ),
        ),
      );
    });
  }
}
