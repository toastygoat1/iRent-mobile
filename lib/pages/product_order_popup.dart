import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/product.dart';
import '../utils/price_utils.dart';
import 'product_order_confirmation_page.dart';

class ProductOrderPopup extends StatefulWidget {
  final Product product;
  const ProductOrderPopup({super.key, required this.product});

  @override
  State<ProductOrderPopup> createState() => _ProductOrderPopupState();
}

class _ProductOrderPopupState extends State<ProductOrderPopup> {
  int _days = 1;

  @override
  Widget build(BuildContext context) {
    final price = widget.product.rentPrice;
    final maxRentDay = widget.product.maxRentDay;
    final totalPrice = calculateTotalPrice(price.round(), _days);
    final formattedPrice = 'Rp ${NumberFormat('#,###', 'id_ID').format(price)}';
    final formattedTotal = 'Rp ${NumberFormat('#,###', 'id_ID').format(totalPrice.round())}';

    return FractionallySizedBox(
      heightFactor: 0.55,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Add instruction text and max rent duration
            const SizedBox(height: 8),
            Text(
              'Select how long you want to rent',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              'Max rent duration: $maxRentDay day(s)',
              style: TextStyle(color: Colors.grey, fontSize: 14),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                widget.product.imageUrl,
                width: 180,
                height: 180,
                fit: BoxFit.fitHeight,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 180,
                  height: 180,
                  color: Colors.grey[300],
                  child: const Icon(Icons.broken_image, size: 48, color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              formattedPrice,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.remove_circle_outline),
                  onPressed: _days > 1
                      ? () => setState(() => _days--)
                      : null,
                ),
                Text('$_days', style: const TextStyle(fontSize: 20)),
                const SizedBox(width: 4),
                const Text('day(s)', style: TextStyle(fontSize: 16)),
                IconButton(
                  icon: const Icon(Icons.add_circle_outline),
                  onPressed: _days < maxRentDay
                      ? () => setState(() => _days++)
                      : null,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text('Total: $formattedTotal', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () => _goToConfirmation(context),
                  child: const Text('OK'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _goToConfirmation(BuildContext context) {
    Navigator.pop(context); // Close the popup first
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductOrderConfirmationPage(
          product: widget.product,
          duration: _days,
        ),
      ),
    );
  }
}
