import 'package:flutter/material.dart';
import '../models/iphones.dart';

class TransactionPage extends StatelessWidget {
  final String selectedColor;
  final int counter;
  final Iphone iphone;

  const TransactionPage({
    Key? key,
    required this.selectedColor,
    required this.counter,
    required this.iphone,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pricePerDay = iphone.storagePrices[selectedColor]!;
    final totalPrice = pricePerDay * counter;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('Transaksi'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          ShoppingCartItem(
            date: _formatTodayDate(),
            productName: '${iphone.title} ($selectedColor)',
            quantity: counter,
            totalPrice: totalPrice,
            status: 'Diproses',
            showReviewButton: false,
            imageUrl: iphone.imageUrl,
          ),
        ],
      ),
    );
  }

  String _formatTodayDate() {
    final now = DateTime.now();
    return '${now.day} ${_getMonthName(now.month)} ${now.year}';
  }

  String _getMonthName(int month) {
    const months = [
      '', 'Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun',
      'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des'
    ];
    return months[month];
  }
}

class ShoppingCartItem extends StatelessWidget {
  final String date;
  final String productName;
  final int quantity;
  final int totalPrice;
  final String status;
  final bool showReviewButton;
  final String imageUrl;

  const ShoppingCartItem({
    Key? key,
    required this.date,
    required this.productName,
    required this.quantity,
    required this.totalPrice,
    required this.status,
    required this.showReviewButton,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Icon(Icons.shopping_bag, color: Colors.blue),
                SizedBox(width: 8),
                Text('Belanja', style: TextStyle(fontWeight: FontWeight.w600)),
                SizedBox(width: 8),
                Text(date, style: TextStyle(color: Colors.grey[600])),
                Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.orange[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),

            // Product details
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  imageUrl,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        productName,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text('Durasi: $quantity hari'),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),

            // Price and summary
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Harga',
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    ),
                    Text(
                      'Rp ${_formatPrice(totalPrice)}',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ],
                ),
                Spacer(),
                if (showReviewButton)
                  TextButton(
                    onPressed: () {},
                    child: Text('Review'),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatPrice(int price) {
    return price.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]}.',
    );
  }
}
