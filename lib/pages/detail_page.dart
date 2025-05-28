import 'package:flutter/material.dart';
import '../models/iphones.dart';

class DetailPage extends StatelessWidget {
  final Iphone iphone;

  const DetailPage({super.key, required this.iphone});

  @override
  Widget build(BuildContext context) {
    return ProductDetailPage(iphone: iphone);
  }
}

class ProductDetailPage extends StatefulWidget {
  final Iphone iphone;

  const ProductDetailPage({super.key, required this.iphone});

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  bool _isExpanded = false;
  String _selectedStorage = '';

  @override
  void initState() {
    super.initState();
    // Set default storage ke yang pertama
    _selectedStorage = widget.iphone.storagePrices.keys.first;
  }

  @override
  Widget build(BuildContext context) {
    final iphone = widget.iphone;
    final currentPrice = iphone.storagePrices[_selectedStorage] ?? 0;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // App Bar
            Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 10,
                left: 16,
                right: 16,
                bottom: 10,
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context); // kembali ke halaman sebelumnya
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      size: 24,
                      color: Colors.black,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Fitur pesan akan segera hadir!')),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Color(0xFF0088CC),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(
                        Icons.message,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Product Images
            Container(
              height: 300,
              child: PageView(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Image.network(
                        iphone.imageUrl,
                        height: 250,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.phone_iphone, size: 80, color: Colors.grey[400]),
                              const SizedBox(height: 10),
                              Text(
                                '${iphone.title}\n${iphone.storagePrices.keys.join(' ')}',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _buildColorCircle(Colors.black),
                                  _buildColorCircle(Colors.white),
                                  _buildColorCircle(Colors.blue[100]!),
                                  _buildColorCircle(Colors.yellow[100]!),
                                  _buildColorCircle(Colors.pink[100]!),
                                ],
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Price Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Rp ${currentPrice.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${iphone.title} $_selectedStorage',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),

            // Storage Options
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Pilih Kapasitas',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Wrap(
                    spacing: 10,
                    children: iphone.storagePrices.keys.map((storage) {
                      final isSelected = storage == _selectedStorage;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedStorage = storage;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: isSelected ? Color(0xFF0088CC) : Colors.white,
                            border: Border.all(
                              color: isSelected ? Color(0xFF0088CC) : Colors.grey[300]!,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            storage,
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.black87,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Detail Produk Section
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Detail produk',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),

                  _buildDetailRow('Status Sinyal', 'Sinyal Aktif'),
                  _buildDetailRow('Tahun Rilis', _getYearFromModel(iphone.title)),
                  _buildDetailRow('Tipe Garansi', 'Garansi Distributor'),
                  _buildDetailRow('Etalase', 'New FS', valueColor: Color(0xFF0088CC)),

                  const SizedBox(height: 30),

                  const Text(
                    'Deskripsi produk',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 15),

                  Text(
                    _isExpanded
                        ? 'Seluruh produk yang kami jual merupakan 100% original, 100% baru, 100% garansi resmi dan kepuasan pelanggan adalah prioritas utama kami.\n\n${iphone.title} hadir dengan teknologi terdepan dan kualitas premium. Dilengkapi dengan berbagai pilihan kapasitas penyimpanan untuk memenuhi kebutuhan Anda.\n\nKeunggulan ${iphone.title}:\n1. Brand new - Original - Segel\n2. Garansi resmi dari distributor\n3. Sudah termasuk dus, charger, dan aksesoris standar\n4. Pengiriman aman dengan bubble wrap dan dus tambahan\n5. Tersedia berbagai pilihan kapasitas\n6. Stock selalu ready dan update\n7. Pelayanan customer service 24/7\n8. Proses pengiriman cepat dan terpercaya'
                        : 'Seluruh produk yang kami jual merupakan 100% original, 100% baru, 100% garansi resmi dan kepuasan pelanggan adalah prioritas utama kami.\n\n${iphone.title} hadir dengan teknologi terdepan dan kualitas premium.',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 15),

                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _isExpanded = !_isExpanded;
                      });
                    },
                    child: Text(
                      _isExpanded ? 'Baca Lebih Sedikit' : 'Baca Selengkapnya',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF0088CC),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Extra space untuk bottom bar
            const SizedBox(height: 100),
          ],
        ),
      ),
      // Bottom App Bar untuk tombol order
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 12,
          bottom: MediaQuery.of(context).padding.bottom + 12,
        ),
        child: SafeArea(
          child: SizedBox(
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${iphone.title} $_selectedStorage berhasil ditambahkan ke keranjang!'),
                    backgroundColor: Color(0xFF0088CC),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF0088CC),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'ORDER',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildColorCircle(Color color) {
    return Container(
      width: 20,
      height: 20,
      margin: const EdgeInsets.symmetric(horizontal: 3),
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.grey[300]!,
          width: 1,
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14,
                color: valueColor ?? Colors.black87,
                fontWeight: valueColor != null ? FontWeight.w500 : FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getYearFromModel(String title) {
    if (title.contains('14')) return '2022';
    if (title.contains('13')) return '2021';
    if (title.contains('12')) return '2020';
    if (title.contains('SE (2022)')) return '2022';
    if (title.contains('11')) return '2019';
    return '2023';
  }
}