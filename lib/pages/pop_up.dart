import 'package:flutter/material.dart';
import '../widgets/main_bottom_nav.dart';

class PopUpPage extends StatefulWidget {
  const PopUpPage({super.key});

  @override
  State<PopUpPage> createState() => _PopUpPageState();
}

class _PopUpPageState extends State<PopUpPage> {
  final List<String> _storage = ['128GB', '256GB', '512GB'];
  final String _imageUrl = 'https://images.tokopedia.net/img/cache/900/VqbcmM/2022/10/28/ba2f9780-c4bc-4f77-a5a4-ce06590eb17e.jpg';
  final String _price = 'Rp100.000';

  int _counter = 1;
  int _selectedColor = 0;

  Future<void> _showBottomSheet(BuildContext context) async {
    int counter = _counter;
    int selectedColor = _selectedColor;
    final result = await showModalBottomSheet<Map<String, int>>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.70,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: StatefulBuilder(
              builder: (context, setModalState) {
                // Intercept back/drag dismiss to return current state
                return WillPopScope(
                  onWillPop: () async {
                    Navigator.pop(context, {
                      'counter': counter,
                      'selectedColor': selectedColor,
                    });
                    return false;
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                _imageUrl,
                                width: 256,
                                height: 256,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              _price,
                              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Text('Ukuran Penyimpanan:', style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Row(
                        children: List.generate(_storage.length, (index) {
                          final isSelected = selectedColor == index;
                          return Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: ChoiceChip(
                              label: Text(_storage[index]),
                              selected: isSelected,
                              onSelected: (_) {
                                setModalState(() {
                                  selectedColor = index;
                                });
                              },
                            ),
                          );
                        }),
                      ),
                      const SizedBox(height: 24),
                      const Text('Durasi Sewa (Hari):', style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: counter > 1
                                ? () => setModalState(() => counter--)
                                : null,
                          ),
                          Text('$counter', style: const TextStyle(fontSize: 18)),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () => setModalState(() => counter++),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context, {
                                'counter': counter,
                                'selectedColor': selectedColor,
                              });
                            },
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () async {
                              final confirm = await showDialog<bool>(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Konfirmasi'),
                                  content: const Text('Apakah Anda yakin dengan pilihan ini?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context, false),
                                      child: const Text('Tidak'),
                                    ),
                                    TextButton(
                                      onPressed: () => Navigator.pop(context, true),
                                      child: const Text('Ya'),
                                    ),
                                  ],
                                ),
                              );
                              if (confirm == true) {
                                Navigator.pop(context, {
                                  'counter': counter,
                                  'selectedColor': selectedColor,
                                });
                              }
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
    if (result != null) {
      setState(() {
        _counter = result['counter'] ?? _counter;
        _selectedColor = result['selectedColor'] ?? _selectedColor;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pop Up Example')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _showBottomSheet(context),
          child: const Text('Show Pop Up'),
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