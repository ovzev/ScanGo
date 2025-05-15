import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../models/cart_item.dart';
import '../models/CartProvider.dart';

class ProductListScreen extends StatefulWidget {
  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<CartItem> products = [
    CartItem(name: 'Milk', price: 1.5, quantity: 1),
    CartItem(name: 'Bread', price: 1.0, quantity: 1),
    CartItem(name: 'Eggs', price: 2.5, quantity: 1),
    CartItem(name: 'Cheese', price: 3.0, quantity: 1),
  ];

  void addToCart(BuildContext context, CartItem product) {
    Provider.of<CartProvider>(context, listen: false).addItem(product);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${product.name} added to cart!')),
    );
  }

  Future<void> scanBarcode(BuildContext context) async {
    String barcode = await FlutterBarcodeScanner.scanBarcode(
      '#6C63FF', 'Cancel', true, ScanMode.BARCODE,
    );

    if (barcode != '-1') {
      var scannedProduct = CartItem(name: 'Product $barcode', price: 5.0, quantity: 1);
      addToCart(context, scannedProduct);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final totalPrice = cart.totalPrice;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Product List',
          style: GoogleFonts.roboto(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.lightBlue[400],
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Text(
            'Total: \$${totalPrice.toStringAsFixed(2)}',
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey[700],
            ),
          ),
          SizedBox(height: 16),
          ...products.map((product) => Card(
            child: ListTile(
              leading: Icon(Icons.shopping_bag),
              title: Text(product.name),
              subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
              trailing: IconButton(
                icon: Icon(Icons.add_shopping_cart),
                onPressed: () => addToCart(context, product),
              ),
            ),
          )),
          SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pushNamed(context, '/cart');
            },
            icon: Icon(Icons.shopping_cart),
            label: Text('Go to Cart'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.lightBlue[300],
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => scanBarcode(context),
        backgroundColor: Colors.lightBlue[300],
        child: Icon(Icons.camera_alt, color: Colors.white),
        tooltip: 'Scan Barcode',
      ),
    );
  }
}
