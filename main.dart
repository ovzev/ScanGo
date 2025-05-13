// main.dart
import 'package:flutter/material.dart';
import 'pages/home_tabs_screen.dart';
import 'pages/login_screen.dart';
import 'pages/cart_screen.dart';
import 'pages/product_list_screen.dart';
import 'pages/payment_screen.dart';
import 'pages/offer_screen.dart';
import 'pages/registration_screen.dart';
import 'pages/profile_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scan and Go',
      initialRoute: '/',
      routes: {
        '/': (context) => HomeTabsScreen(),
        '/login': (context) => LoginScreen(),
        '/cart': (context) => CartScreen(),
        '/products': (context) => ProductListScreen(),
        '/payment': (context) => PaymentScreen(),
        '/offers': (context) => OfferScreen(),
        '/register': (context) => RegistrationScreen(),
        '/profile': (context) => ProfileScreen(),
      },
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}
