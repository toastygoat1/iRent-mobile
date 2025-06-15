import 'package:flutter/material.dart';
import '../models/product.dart';
import 'product_order_popup.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;
  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name, maxLines: 1, overflow: TextOverflow.ellipsis),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    product.imageUrl,
                    height: 220,
                    width: double.infinity,
                    fit: BoxFit.fitHeight,
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 220,
                      color: Colors.grey[300],
                      child: const Icon(Icons.broken_image, size: 64, color: Colors.grey),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(product.name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Row(
                children: [
                  Chip(label: Text('Color: ${product.color}')),
                  const SizedBox(width: 8),
                  Chip(label: Text('Storage: ${product.storage}')),
                ],
              ),
              const SizedBox(height: 8),
              Text('Rent Price: Rp${product.rentPrice.toStringAsFixed(0)}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              Text('Partner: ${product.partner.name}', style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 16),
              const Text('Description:', style: TextStyle(fontWeight: FontWeight.bold)),
              Text(product.description),
              const SizedBox(height: 32),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                      ),
                      builder: (context) => ProductOrderPopup(product: product),
                    );
                  },
                  child: const Text('Order'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                    textStyle: const TextStyle(fontSize: 18),
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
