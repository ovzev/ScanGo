import 'package:flutter/material.dart';
import 'product_detail_page.dart'; // تأكد من استيراد صفحة تفاصيل المنتج هنا

class NewItemsPage extends StatefulWidget {
  @override
  _NewItemsPageState createState() => _NewItemsPageState();
}

class _NewItemsPageState extends State<NewItemsPage> {
  final List<Map<String, String>> allItems = [
    {
      'name': 'Bag',
      'image': 'assets/images/bags.jpg',
      'description': 'Stylish leather bag perfect for work and travel.',
      'features': 'Lightweight, Water-resistant, Modern design',
    },
    {
      'name': 'Watch',
      'image': 'assets/images/watch.jpg',
      'description': 'Elegant smart watch with fitness tracking.',
      'features': 'Heart rate monitor, GPS, Long battery life',
    },
    {
      'name': 'Sunglasses',
      'image': 'assets/images/sunglasses.jpg',
      'description': 'UV-protective sunglasses with cool frames.',
      'features': 'Polarized, Scratch-resistant, Stylish look',
    },
    {
      'name': 'Shoes',
      'image': 'assets/images/shoes.jpg',
      'description': 'Comfortable running shoes for daily use.',
      'features': 'Breathable, Soft sole, Durable',
    },
    {
      'name': 'Shirt',
      'image': 'assets/images/shirt.jpg',
      'description': 'Cotton shirt available in many colors.',
      'features': '100% cotton, Slim fit, Machine washable',
    },
    {
      'name': 'Pants',
      'image': 'assets/images/pants.jpg',
      'description': 'Casual pants perfect for work or weekends.',
      'features': 'Stretchable, Multiple pockets, Soft fabric',
    },
  ];

  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final filteredItems = allItems
        .where((item) =>
        item['name']!.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'New Items You Might Like',
          style: TextStyle(
            color: Colors.blue,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.blue),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              onChanged: (value) => setState(() => searchQuery = value),
              decoration: InputDecoration(
                hintText: 'Search items...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                itemCount: filteredItems.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemBuilder: (context, index) {
                  final item = filteredItems[index];
                  return GestureDetector(
                    onTap: () {
                      // فتح Dialog عند الضغط على أي منتج
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(
                              item['name']!,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  item['image']!,
                                  height: 100, // صورة أصغر في الـ Dialog
                                  width: 100,
                                  fit: BoxFit.cover,
                                ),
                                SizedBox(height: 10),
                                Text(
                                  item['description']!, // عرض وصف بسيط
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[700],
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            actions: [
                              // خيار إغلاق الـ Dialog
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context); // إغلاق الـ Dialog
                                },
                                child: Text('Close'),
                              ),
                              // خيار الانتقال إلى صفحة التفاصيل
                              TextButton(
                                onPressed: () {
                                  // الانتقال إلى صفحة تفاصيل المنتج
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => ProductDetailPage(
                                        product: item,
                                      ),
                                    ),
                                  );
                                },
                                child: Text('More Details'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(item['image']!, height: 120, width: 120), // صورة أكبر في الـ Grid
                          SizedBox(height: 8),
                          Text(
                            item['name']!,
                            style: TextStyle(
                              color: Colors.blue[800],
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
