import 'package:pokopedia/provider/product_provider.dart';

import '../controllers/main_provider.dart';
import '../pages/cart_page.dart';
import '../pages/home_page.dart';
import '../pages/product_page.dart';
import '../pages/profile_page.dart';
import '../pages/transaction_page.dart';
import '../widgets/poko_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'controllers/user_provider.dart';
import 'provider/category_provider.dart';
import 'widgets/bottom_navbar.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => MainNotifier()),
    ChangeNotifierProvider(create: (context) => UserNotifier()),
    ChangeNotifierProvider(create: (context) => ProductProvider()),
    ChangeNotifierProvider(create: (context) => CategoryProvider()),
  ], child: MainPage()));
}

class MainPage extends StatelessWidget {
  MainPage({super.key});
  List<Widget> pageList = [
    const HomePage(),
    const ProductPage(),
    const CartPage(),
    const TransactionPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<MainNotifier>(builder: (context, mainNotifier, child) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: const PokoAppBar(),
          body: pageList[mainNotifier.pageIndex],
          bottomNavigationBar: const BottomNavbar(),
        ),
      );
    });
  }
}
