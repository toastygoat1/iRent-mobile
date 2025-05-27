import 'package:flutter/material.dart';
import '../widgets/product_card.dart';
import '../widgets/homepage_bottomnav.dart';

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
        title: const Text('Nanti ini gak ada y'),
        actions: const [Icon(Icons.chat_rounded)],
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