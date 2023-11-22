import 'package:pokopedia/provider/page_provider.dart';
import 'package:pokopedia/pages/login_page.dart';
import 'package:pokopedia/provider/product_provider.dart';

import '../pages/cart_page.dart';
import '../pages/home_page.dart';
import '../pages/product_page.dart';
import '../pages/profile_page.dart';
import '../pages/transaction_page.dart';
import '../widgets/poko_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider/category_provider.dart';
import 'provider/user_provider.dart';
import 'widgets/bottom_navbar.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => PageProvider()),
    ChangeNotifierProvider(create: (context) => UserProvider()),
    ChangeNotifierProvider(create: (context) => ProductProvider()),
    ChangeNotifierProvider(create: (context) => CategoryProvider()),
  ], child: const MainPage()));
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Widget> pageList = [
    const HomePage(),
    const ProductPage(),
    const CartPage(),
    const TransactionPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer2<PageProvider, UserProvider>(
        builder: (context, pageState, userState, child) {
      String? accessToken = userState.accessToken;
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: accessToken != null
            ? Scaffold(
                appBar: const PokoAppBar(),
                body: pageList[pageState.pageIndex],
                bottomNavigationBar: const BottomNavbar(),
              )
            : const LoginPage(),
      );
    });
  }
}
