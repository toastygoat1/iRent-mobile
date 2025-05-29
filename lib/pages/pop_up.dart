import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/iphones.dart';
import '../utils/price_utils.dart';
import 'confirmation_page.dart';

class PopUpPage extends StatefulWidget {
  final Iphone iphone;

  const PopUpPage({super.key, required this.iphone});

  @override
  State<PopUpPage> createState() => _PopUpPageState();
}

class _PopUpPageState extends State<PopUpPage> {
  int _counter = 1;
  int _selectedColor = 0;

  @override
  Widget build(BuildContext context) {
    final storageList = widget.iphone.storagePrices.keys.toList();
    final selectedStorage = storageList[_selectedColor];
    final price = widget.iphone.storagePrices[selectedStorage]!;
    final totalPrice = calculateTotalPrice(price, _counter);
    final formattedPrice = 'Rp ${NumberFormat('#,###', 'id_ID').format(price)}';
    final formattedTotal =
        'Rp ${NumberFormat('#,###', 'id_ID').format(totalPrice.round())}';

    return FractionallySizedBox(
      heightFactor: 0.70,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
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
                        widget.iphone.imageUrl,
                        width: 200,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      formattedPrice,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Ukuran Penyimpanan:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Row(
                children: List.generate(storageList.length, (index) {
                  final isSelected = _selectedColor == index;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ChoiceChip(
                      label: Text(storageList[index]),
                      selected: isSelected,
                      onSelected: (_) {
                        setState(() {
                          _selectedColor = index;
                        });
                      },
                    ),
                  );
                }),
              ),
              const SizedBox(height: 24),
              const Text(
                'Durasi Sewa (Hari):',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: _counter > 1
                        ? () => setState(() => _counter--)
                        : null,
                  ),
                  Text('$_counter', style: const TextStyle(fontSize: 18)),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () => setState(() => _counter++),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Text(
                'Total: $formattedTotal',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 60),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel', style: TextStyle(fontSize: 16),),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context); // Tutup PopUpPage dulu
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ConfirmationPage(
                            iphone: widget.iphone,
                            selectedStorage: selectedStorage,
                            duration: _counter,
                          ),
                        ),
                      );
                    },
                    child: const Text('OK', style: TextStyle(fontSize: 16)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
