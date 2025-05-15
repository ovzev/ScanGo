import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../models/cart_item.dart';
import '../models/CartProvider.dart';

class ProductDetailPage extends StatefulWidget {
  final Map<String, String> product;

  const ProductDetailPage({required this.product});

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  Color selectedColor = Colors.transparent;

  late String productBrand;
  late double productPrice;

  final List<String> brandNames = [
    'Nike', 'Adidas', 'Puma', 'Under Armour', 'Reebok',
    'New Balance', 'Fila', 'Vans', 'Converse', 'Champion'
  ];

  @override
  void initState() {
    super.initState();

    final random = Random();
    productBrand = brandNames[random.nextInt(brandNames.length)];
    productPrice = 20 + random.nextInt(80) + random.nextDouble();
  }

  void addToCart(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    final item = CartItem(
      name: widget.product['name'] ?? 'Unknown',
      price: productPrice,
      quantity: 1,
      image: widget.product['image'] ?? '',
    );

    cartProvider.addItem(item);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${widget.product['name']} added to cart!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final String productName = widget.product['name'] ?? 'Unknown';
    final String productDescription = widget.product['description'] ?? 'No description available.';
    final String productFeatures = widget.product['features'] ?? 'No features available.';

    List<Color> colorOptions = [
      Colors.red, Colors.blue, Colors.green, Colors.yellow,
      Colors.black, Colors.white, Colors.purple, Colors.orange,
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          productName,
          style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue[400],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                widget.product['image'] ?? 'assets/default_image.png',
                height: 200,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 30),
              Text(
                productDescription,
                style: GoogleFonts.lato(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[800],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Text(
                'Features:',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[800],
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 10),
              Text(
                productFeatures,
                style: GoogleFonts.lato(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 20),
              Text(
                'Brand: $productBrand',
                style: GoogleFonts.lato(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue[700],
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Price: \$${productPrice.toStringAsFixed(2)}',
                style: GoogleFonts.lato(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[800],
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Available Colors:',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[800],
                ),
              ),
              SizedBox(height: 10),
              Wrap(
                spacing: 8,
                children: colorOptions.map((color) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedColor = color;
                      });
                    },
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: color,
                      child: selectedColor == color
                          ? Icon(Icons.check, color: Colors.white)
                          : null,
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () => addToCart(context),
                icon: Icon(Icons.shopping_cart),
                label: Text('Add to Cart'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                  backgroundColor: Colors.blue,
                  textStyle: GoogleFonts.poppins(fontSize: 18),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Back to Products',
                  style: GoogleFonts.lato(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
