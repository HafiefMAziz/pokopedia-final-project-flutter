import 'package:pokopedia/provider/page_provider.dart';
import 'package:pokopedia/pages/login_page.dart';
import 'package:pokopedia/provider/product_provider.dart';

import '../pages/cart_page.dart';
import '../pages/home_page.dart';
import '../pages/product_page.dart';
import '../pages/profile_page.dart';
import 'pages/transactions_list_page.dart';
import '../widgets/poko_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider/cart_provider.dart';
import 'provider/category_provider.dart';
import 'provider/payment_provider.dart';
import 'provider/transaction_provider.dart';
import 'provider/user_provider.dart';
import 'widgets/bottom_navbar.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => PageProvider()),
    ChangeNotifierProvider(create: (context) => UserProvider()),
    ChangeNotifierProvider(create: (context) => ProductProvider()),
    ChangeNotifierProvider(create: (context) => CategoryProvider()),
    ChangeNotifierProvider(create: (context) => CartProvider()),
    ChangeNotifierProvider(create: (context) => PaymentProvider()),
    ChangeNotifierProvider(create: (context) => TransactionProvider()),
  ], child: const MainPage()));
}

class MainPage extends StatefulWidget {
  const MainPage({super.key, this.pageIndex});
  final dynamic pageIndex;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Widget> pageList = [
    const HomePage(),
    const ProductPage(),
    const CartPage(),
    const TransactionListPage(),
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
                body: widget.pageIndex != null ? pageList[widget.pageIndex] : pageList[pageState.pageIndex],
                bottomNavigationBar: const BottomNavbar(),
              )
            : const LoginPage(),
      );
    });
  }
}
