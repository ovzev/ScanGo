import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts package

class OfferScreen extends StatelessWidget {
  final List<Map<String, String>> offers = [
    {
      'title': '50% Off on Electronics',
      'imageUrl': "assets/images/50.jpg",  // تأكد من أن هذا المسار صحيح
      'description': 'Get the best deals on latest gadgets!',
    },
    {
      'title': 'Buy 1 Get 1 Free',
      'imageUrl': "assets/images/free.jpg", // تأكد من أن هذا المسار صحيح
      'description': 'Special offer on selected fashion items.',
    },
    {
      'title': 'Supermarket Sale',
      'imageUrl': "assets/images/sale.jpg", // تأكد من أن هذا المسار صحيح
      'description': 'Discounts up to 30% on daily essentials.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // عدد التبويبات
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(

          bottom: TabBar(
            tabs: [
              Tab(text: 'All Offers'),
              Tab(text: 'Exclusive'),
              Tab(text: 'Summer Sale'),
            ],
          ),
          backgroundColor: Colors.lightBlue[300],
        ),
        body: TabBarView(
          children: [
            // Tab for all offers
            ListView.builder(
              padding: EdgeInsets.all(16.0),
              itemCount: offers.length,
              itemBuilder: (context, index) {
                final offer = offers[index];
                return _buildOfferCard(offer, context);
              },
            ),
            // Tab for exclusive offers (محتوى مؤقت)
            Center(
              child: Text(
                'Exclusive Offers Coming Soon!',
                style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            // Tab for summer sale offers (محتوى مؤقت)
            Center(
              child: Text(
                'Summer Sale Offers Coming Soon!',
                style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOfferCard(Map<String, String> offer, BuildContext context) {
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
            child: Image.asset(  // استخدم Image.asset بدلاً من Image.network للصور المحلية
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
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.lightBlue[300],
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  offer['description']!,
                  style: GoogleFonts.lato(
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, '/cart'); // تأكد من المسار الصحيح هنا
                    },
                    icon: Icon(Icons.shopping_bag),
                    label: Text(
                      'Shop Now',
                      style: GoogleFonts.lato(fontSize: 16),
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
  }
}
