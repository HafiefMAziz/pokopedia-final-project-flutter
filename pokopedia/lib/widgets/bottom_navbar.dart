import '../controllers/page_provider.dart';
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
    return Consumer<PageProvider>(builder: (context, pageState, child) {
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
                  pageState.pageIndex = 0;
                },
                icon: Icons.home_rounded,
                selected: pageState.pageIndex == 0 ? true : false,
              ),
              BottomNavIcon(
                onTap: () {
                  pageState.pageIndex = 1;
                },
                icon: Icons.category_rounded,
                selected: pageState.pageIndex == 1 ? true : false,
              ),
              BottomNavIcon(
                onTap: () {
                  pageState.pageIndex = 2;
                },
                icon: Icons.shopping_bag,
                selected: pageState.pageIndex == 2 ? true : false,
              ),
              BottomNavIcon(
                onTap: () {
                  pageState.pageIndex = 3;
                },
                icon: Icons.list_rounded,
                selected: pageState.pageIndex == 3 ? true : false,
              ),
              BottomNavIcon(
                onTap: () {
                  pageState.pageIndex = 4;
                },
                icon: Icons.person,
                selected: pageState.pageIndex == 4 ? true : false,
              ),
            ],
          ),
        ),
      );
    });
  }
}
