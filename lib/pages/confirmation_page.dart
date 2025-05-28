import 'package:flutter/material.dart';
import 'package:irent/pages/home_page.dart';
import 'package:irent/pages/transaksi_page.dart';
import 'package:provider/provider.dart';
import '../models/iphones.dart';
import '../models/sewa.dart';
import '../utils/date_utils.dart';
import '../viewmodels/sewa_viewmodels.dart';

class ConfirmationPage extends StatelessWidget {
  final Iphone iphone;
  final String selectedStorage;
  final int duration;

  const ConfirmationPage({
    super.key,
    required this.iphone,
    required this.selectedStorage,
    required this.duration,
  });

  double _calculateTotalPrice(int pricePerDay, int duration) {
    double total = 0;
    for (int i = 0; i < duration; i++) {
      total += pricePerDay * (1 + 0.05 * i);
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    final pricePerDay = iphone.storagePrices[selectedStorage]!;
    final totalPrice = _calculateTotalPrice(pricePerDay, duration);

    return Scaffold(
      appBar: AppBar(title: const Text('Konfirmasi Pesanan')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar dan Info iPhone
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    iphone.imageUrl,
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
                      Text(iphone.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Text('Penyimpanan: $selectedStorage'),
                      Text('Durasi: $duration hari'),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),

            // Harga
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Total Harga', style: TextStyle(fontSize: 16)),
                  Text('Rp ${_formatPrice(totalPrice.round())}',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                ],
              ),
            ),

            const Spacer(),

            // Tombol Konfirmasi & Batal
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 48,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.blue),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        'Batal',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: SizedBox(
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () {
                        // Tambahkan transaksi ke Provider & navigasi
                        Provider.of<TransactionProvider>(context, listen: false).addTransaction(
                            Transaction(
                              productName: iphone.title,
                              quantity: duration,
                              totalPrice: totalPrice.round(),
                              date: getTodayDate(),
                              status: 'Selesai',
                              imageUrl: iphone.imageUrl,
                            ),
                        );
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (_) => const TransactionPage()),
                        (route) => false,
                        );
                      },
                      child: const Text(
                        'Pesan Sekarang',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
                      ),
                    ),
                  ),
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
          (m) => '${m[1]}.',
    );
  }
}
