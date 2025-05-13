// pages/offer_screen.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OfferScreen extends StatelessWidget {
  final List<Map<String, String>> offers = [
    {'title': '50% Off on Electronics', 'imageUrl': 'assets/images/50.jpg'},
    {'title': 'Buy 1 Get 1 Free', 'imageUrl': 'assets/images/free.jpg'},
    {'title': 'Supermarket Sale', 'imageUrl': 'assets/images/sale.jpg'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Special Offers', style: GoogleFonts.poppins())),
      body: ListView.builder(
        itemCount: offers.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(offers[index]['imageUrl']!, height: 200, width: double.infinity, fit: BoxFit.cover),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(offers[index]['title']!, style: GoogleFonts.lato(fontSize: 18)),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
