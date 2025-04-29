import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:google_fonts/google_fonts.dart';  // Import Google Fonts package

import '../models/cart_item.dart';

class ProductListScreen extends StatefulWidget {
  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<CartItem> cartItems = [];

  Future<void> scanBarcode() async {
    String barcode = await FlutterBarcodeScanner.scanBarcode(
      '#6C63FF', 'Cancel', true, ScanMode.BARCODE,
    );

    if (barcode != '-1') {
      print('Scanned Barcode: $barcode');

      var newProduct = CartItem(name: 'Product $barcode', price: 5.0, quantity: 1);

      setState(() {
        bool productExists = false;
        for (var item in cartItems) {
          if (item.name == newProduct.name) {
            item.quantity++;
            productExists = true;
            break;
          }
        }

        if (!productExists) {
          cartItems.add(newProduct);
        }
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Product added to cart!')),
      );
    }
  }

  double get totalPrice {
    return cartItems.fold(0.0, (sum, item) => sum + item.price * item.quantity);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          'Product List',
          style: GoogleFonts.roboto(fontWeight: FontWeight.bold), // Updated font for AppBar
        ),
        backgroundColor: Colors.lightBlue[400],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Total: \$${totalPrice.toStringAsFixed(2)}',
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey[700],
                ), // Custom font for total price
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/cart');
              },
              icon: Icon(Icons.shopping_cart),
              label: Text(
                'Go to Cart',
                style: GoogleFonts.lato(fontSize: 18), // Custom font for button label
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightBlue[300],
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
            ),
            SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/offers');
              },
              icon: Icon(Icons.local_offer),
              label: Text(
                'Go to Offers',
                style: GoogleFonts.lato(fontSize: 18), // Custom font for button label
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey[300],
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: scanBarcode,
        backgroundColor: Colors.lightBlue[300],
        child: Icon(Icons.camera_alt, color: Colors.white),
        tooltip: 'Scan Barcode',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
