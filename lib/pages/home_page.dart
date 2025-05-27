import 'package:flutter/material.dart';
import '../widgets/product_card.dart';
import '../widgets/main_bottom_nav.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final items = List.generate(8, (index) => {
      'image': 'https://images.tokopedia.net/img/cache/900/VqbcmM/2022/10/28/ba2f9780-c4bc-4f77-a5a4-ce06590eb17e.jpg',
      'title': 'iPhone 14 Pro Midnight Super Super Super Super Long Title  $index',
      'price': 'Rp100.000'
    });
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
                padding: const EdgeInsets.symmetric(horizontal:4),
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
            const Icon(Icons.chat_rounded),
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
          children: items.map((item) => ProductCard(
            imageUrl: item['image']!,
            title: item['title']!,
            price: item['price']!,
          )).toList(),
        ),
      ),
      bottomNavigationBar: MainBottomNav(
        currentIndex: 0,
        onTap: (index) {
          // Handle navigation here
        },
      ),
    );
  }
}