import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';  // Import Google Fonts package

class OfferScreen extends StatelessWidget {
  final List<Map<String, String>> offers = [
    {
      'title': '50% Off on Electronics',
      'imageUrl': "assets/images/50.jpg",
      'description': 'Get the best deals on latest gadgets!',
    },
    {
      'title': 'Buy 1 Get 1 Free',
      'imageUrl': "assets/images/free.jpg",
      'description': 'Special offer on selected fashion items.',
    },
    {
      'title': 'Supermarket Sale',
      'imageUrl': "assets/images/sale.jpg",
      'description': 'Discounts up to 30% on daily essentials.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          'Special Offers',
          style: GoogleFonts.roboto(fontWeight: FontWeight.bold), // Custom font for the AppBar title
        ),
        backgroundColor: Colors.lightBlue[300],
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: offers.length,
        itemBuilder: (context, index) {
          final offer = offers[index];
          return Card(
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                  child: Image.network(
                    offer['imageUrl']!,
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        offer['title']!,
                        style: GoogleFonts.poppins(  // Custom font for the offer title
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.lightBlue[300],
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        offer['description']!,
                        style: GoogleFonts.lato( // Custom font for the offer description
                          fontSize: 16,
                          color: Colors.grey[700],
                        ),
                      ),
                      SizedBox(height: 12),
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            // Navigate to the Cart Screen when the "Shop Now" button is pressed
                            Navigator.pushNamed(context, '/cart'); // This line should be updated based on your route
                          },
                          icon: Icon(Icons.shopping_bag),
                          label: Text(
                            'Shop Now',
                            style: GoogleFonts.lato(fontSize: 16), // Custom font for the button text
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.lightBlue[300],
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
