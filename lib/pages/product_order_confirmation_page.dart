import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/product.dart';
import '../utils/price_utils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ProductOrderConfirmationPage extends StatefulWidget {
  final Product product;
  final int duration;

  const ProductOrderConfirmationPage({super.key, required this.product, required this.duration});

  @override
  State<ProductOrderConfirmationPage> createState() => _ProductOrderConfirmationPageState();
}

class _ProductOrderConfirmationPageState extends State<ProductOrderConfirmationPage> {
  DateTime? _startDate;
  bool _isLoading = false;

  Future<int?> _getCustomerId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('customer_id');
  }

  Future<void> _submitOrder() async {
    if (_startDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please select a start date.')));
      return;
    }
    setState(() { _isLoading = true; });
    final customerId = await _getCustomerId();
    if (customerId == null) {
      setState(() { _isLoading = false; });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('User not logged in.')));
      return;
    }
    final endDate = _startDate!.add(Duration(days: widget.duration));
    final url = Uri.parse('http://10.0.2.2:8000/api/orders');
    final prefs = await SharedPreferences.getInstance();
    final body = {
      'product_id': widget.product.id.toString(),
      'customer_id': customerId.toString(),
      'partner_id': widget.product.partner.id.toString(),
      'start_date': _startDate!.toIso8601String().substring(0, 10),
      'end_date': endDate.toIso8601String().substring(0, 10),
      'duration': widget.duration.toString(),
      'total_price': calculateTotalPrice(widget.product.rentPrice.round(), widget.duration).toStringAsFixed(2),
      'status': 'waiting',
      'product_name': widget.product.name,
      'product_image_url': widget.product.imageUrl,
      'customer_name': prefs.getString('userName') ?? '',
      'partner_name': widget.product.partner.name,
    };
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(body),
      );
      setState(() { _isLoading = false; });
      if (response.statusCode == 201 || response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Order placed successfully!')));
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to place order: \\${response.body}')));
      }
    } catch (e) {
      setState(() { _isLoading = false; });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: \\${e.toString()}')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final totalPrice = calculateTotalPrice(widget.product.rentPrice.round(), widget.duration);
    final formattedTotal = 'Rp ${NumberFormat('#,###', 'id_ID').format(totalPrice.round())}';
    final endDate = _startDate != null ? _startDate!.add(Duration(days: widget.duration)) : null;

    return Scaffold(
      appBar: AppBar(title: const Text('Order Confirmation')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    widget.product.imageUrl,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.product.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Text('Color: ${widget.product.color}'),
                      Text('Storage: ${widget.product.storage}'),
                      Text('Duration: ${widget.duration} day(s)'),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text('Total Price: $formattedTotal', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 24),
            const Text('Choose Start Date:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                    );
                    if (picked != null) {
                      setState(() {
                        _startDate = picked;
                      });
                    }
                  },
                  child: const Text('Select Start Date'),
                ),
                const SizedBox(width: 16),
                Text(_startDate != null ? DateFormat('dd MMM yyyy').format(_startDate!) : 'No date chosen'),
              ],
            ),
            const SizedBox(height: 16),
            if (_startDate != null)
              Text('End Date: ${DateFormat('dd MMM yyyy').format(endDate!)}', style: const TextStyle(fontSize: 16)),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: _startDate != null && !_isLoading ? _submitOrder : null,
                child: _isLoading
                    ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(strokeWidth: 2))
                    : const Text('Confirm Order'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
