import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/product.dart';
import '../widgets/product_card.dart';
import 'home_page.dart';
import '../services/product_service.dart';
import 'product_detail_page.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late Future<List<Product>> _futureProducts;
  final ProductService _productService = ProductService();

  @override
  void initState() {
    super.initState();
    _futureProducts = _productService.fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text('Products'),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
              child: const Text('Go to Home'),
            ),
          ],
        ),
      ),
      body: FutureBuilder<List<Product>>(
        future: _futureProducts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: \${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No products found.'));
          }
          final items = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 0.75,
              children: items
                  .map(
                    (item) => ProductCard(
                      imageUrl: item.imageUrl,
                      title: item.name,
                      price: 'Rp${NumberFormat('#,###', 'id_ID').format(item.rentPrice)}',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetailPage(product: item),
                          ),
                        );
                      },
                    ),
                  )
                  .toList(),
            ),
          );
        },
      ),
    );
  }
}