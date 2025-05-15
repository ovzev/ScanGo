import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // ⬅️ لإعداد Firebase
import 'package:firebase_auth/firebase_auth.dart';
import 'pages/login_screen.dart';
import 'pages/cart_screen.dart';
import 'pages/product_list_screen.dart';
import 'pages/payment_screen.dart';
import 'pages/offer_screen.dart';
import 'pages/registration_screen.dart';
import 'pages/home_screen.dart';
import 'package:provider/provider.dart';
import 'models/CartProvider.dart';


void main() {//async {
  //WidgetsFlutterBinding.ensureInitialized(); // ⬅️ ضروري لتهيئة Firebase
   Firebase.initializeApp(options: FirebaseOptions(apiKey: "AIzaSyAXcEbkxm4z888BX7yZkX5ZuOb-gfhTY1M",
       authDomain: "scan-and-go-c0723.firebaseapp.com",
       projectId: "scan-and-go-c0723",
       storageBucket: "scan-and-go-c0723.firebasestorage.app",
       messagingSenderId: "1000828543541",
       appId: "1:1000828543541:web:e26070c4dd4fc8ee4e077c",
       measurementId: "G-35YDVE0ESW")); // ⬅️ تهيئة Firebase
   runApp(
     ChangeNotifierProvider(
       create: (context) => CartProvider(),
       child: MyApp(),
     ),
   );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scan and Go',
      debugShowCheckedModeBanner: false,
      initialRoute: '/login', // نبدأ من صفحة تسجيل الدخول

      routes: {
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegistrationScreen(),
        '/home': (context) => HomeScreen(),
        '/cart': (context) => CartScreen(),
        '/products': (context) => ProductListScreen(),
        '/payment': (context) => PaymentScreen(),
        '/offers': (context) => OfferScreen(),
      },
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}
