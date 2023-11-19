import 'package:pokopedia/providers/product_provider.dart';

import '../controllers/main_provider.dart';
import '../pages/cart_page.dart';
import '../pages/home_page.dart';
import '../pages/product_page.dart';
import '../pages/profile_page.dart';
import '../pages/transaction_page.dart';
import '../widgets/poko_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widgets/bottom_navbar.dart';

void main() {
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MainNotifier()), 
        ChangeNotifierProvider(create: (context) => ProductProvider()), 
        ],
      child: MainPage()));
}

class MainPage extends StatelessWidget {
  MainPage({super.key});
  List<Widget> pageList = [
    const HomePage(accessToken: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwidXNlcm5hbWUiOiJhZG1pbjEyMyIsImVtYWlsIjoiYWRtaW4xMjNAbWFpbC5jb20iLCJmdWxsbmFtZSI6IlN1cGVyIEFkbWluIiwiYXZhdGFyIjoiaHR0cHM6Ly9iYW5uZXIyLmNsZWFucG5nLmNvbS8yMDE4MDQwMi9vancva2lzc3BuZy11bml0ZWQtc3RhdGVzLWF2YXRhci1vcmdhbml6YXRpb24taW5mb3JtYXRpb24tdXNlci1hdmF0YXItNWFjMjA4MDRhNjJiNTguODY3MzYyMDIxNTIyNjY1NDc2NjgwNi5qcGciLCJhZGRyZXNzIjoiZGlhbW5hIGtqYWprYSIsImlzQWRtaW4iOnRydWUsImlhdCI6MTcwMDEyOTUxOH0.cTOxDoNCWxSIXD8C_MbCTCcX-qnVc7mURiYzBCAFu8w"),
    const ProductPage(),
    const CartPage(),
    const TransactionPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<MainNotifier>(builder: (context, mainNotifier, child) {
      return MaterialApp(
        home: SafeArea(
          child: Scaffold(
            appBar: const PokoAppBar(),
            body: pageList[mainNotifier.pageIndex],
            bottomNavigationBar: const BottomNavbar(),
          ),
        ),
      );
    });
  }
}


