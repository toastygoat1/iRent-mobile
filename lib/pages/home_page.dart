import 'package:flutter/material.dart';
import '../widgets/product_card.dart';
import '../widgets/main_bottom_nav.dart';
import '../models/iphones.dart';
import 'detail_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final items = iphones;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(
              child: Container(
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey, width: 1),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Row(
                  children: const [
                    Icon(Icons.search, color: Colors.grey),
                    SizedBox(width: 8),
                    Text(
                      'Search',
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 16),
            const Icon(Icons.chat_bubble_outline_rounded, color: Colors.grey, size: 28),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          childAspectRatio: 0.75,
          children: items.map((item) => GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailPage(iphone: item),
                ),
              );
            },
            child: ProductCard(
              imageUrl: item.imageUrl,
              title: item.title,
              price: 'Rp${item.storagePrices.values.first}',
            ),
          )).toList(),
        ),
      ),
      bottomNavigationBar: MainBottomNav(
        currentIndex: 0,
        onTap: (index) {
          if (index == 0) {
            // Sudah di Home, tidak perlu pindah
          } else if (index == 1) {
            Navigator.pushNamed(context, '/transactions');
          } else if (index == 2) {
            Navigator.pushNamed(context, '/profile');
          }
        },
      ),

    );
  }
}