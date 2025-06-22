import 'package:flutter/material.dart';
import '../models/order.dart';
import '../models/product.dart' as product_model;
import '../services/order_service.dart';
import '../services/product_service.dart';
import '../utils/customer_utils.dart';
import '../widgets/main_bottom_nav.dart';
import 'product_page.dart';
import 'profile_page.dart';
import 'notification_page.dart';

class OrderListPage extends StatefulWidget {
  const OrderListPage({super.key});

  @override
  State<OrderListPage> createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage> {
  // Remove the 'late' keyword and initialize _futureOrders and _futureProducts as nullable
  Future<List<Order>>? _futureOrders;
  Future<List<product_model.Product>>? _futureProducts;
  final OrderService _orderService = OrderService();
  final ProductService _productService = ProductService();
  int? _customerId;
  TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _futureOrders = _orderService.fetchOrders();
    _futureProducts = _productService.fetchProducts();
    _loadCustomerId();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadCustomerId() async {
    final id = await CustomerUtils.getCustomerId();
    setState(() {
      _customerId = id;
    });
  }

  // Helper: show pickup info popup
  void _showPickupInfoDialog(BuildContext context, Order order) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(24, 32, 24, 20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue.shade50, Colors.blue.shade100, Colors.white],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(22),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 18,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.blue.shade100,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Icon(Icons.store_mall_directory, color: Colors.blue, size: 28),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Pickup Information',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.blueAccent,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  _infoRow(Icons.location_on, 'Pickup Address', order.pickupAddress),
                  const Divider(height: 24, thickness: 1, color: Colors.blueGrey),
                  _infoRow(Icons.phone, 'Contact Number', order.contactNumber),
                  const Divider(height: 24, thickness: 1, color: Colors.blueGrey),
                  _infoRow(Icons.access_time, 'Pickup Time', order.pickupTime),
                  const Divider(height: 24, thickness: 1, color: Colors.blueGrey),
                  _infoRow(Icons.sticky_note_2, 'Notes', order.notes),
                  const SizedBox(height: 18),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close, size: 18, color: Colors.white),
                      label: const Text('Close', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              right: 8,
              top: 8,
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(6.0),
                    child: Icon(Icons.close, size: 20, color: Colors.blueGrey),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper: show finished info popup
  void _showFinishedInfoDialog(BuildContext context, Order order) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        title: Row(
          children: [
            const Icon(Icons.assignment_turned_in, color: Colors.green, size: 28),
            const SizedBox(width: 8),
            const Text('Return Information', style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _infoRow(Icons.person, 'Partner', order.partner.name),
            _infoRow(Icons.calendar_today, 'Return Date', order.endDate),
            _infoRow(Icons.info_outline, 'Return Info', order.returnInformation),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  // Helper: show return now info popup
  void _showReturnNowInfoDialog(BuildContext context, Order order) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        title: Row(
          children: [
            const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 28),
            const SizedBox(width: 8),
            const Text('Return Now', style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: Colors.orange[50],
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.orange, width: 1),
              ),
              child: const Text(
                'Your rent duration has ended. Please return the iPhone now.\n\nPlease return the phone on time and in good condition because if it is not you will get charged.',
                style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold, fontSize: 13),
              ),
            ),
            _infoRow(Icons.person, 'Partner', order.partner.name),
            _infoRow(Icons.location_on, 'Pickup Address', order.pickupAddress),
            _infoRow(Icons.phone, 'Contact Number', order.contactNumber),
            _infoRow(Icons.access_time, 'Pickup Time', order.pickupTime),
            _infoRow(Icons.sticky_note_2, 'Notes', order.notes),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, dynamic value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: Colors.blueGrey),
          const SizedBox(width: 8),
          Text('$label: ', style: const TextStyle(fontWeight: FontWeight.w600)),
          Expanded(
            child: Text(
              value == null || (value is String && value.isEmpty) ? '-' : value.toString(),
              style: const TextStyle(fontWeight: FontWeight.normal),
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  // Helper function to format date range
  String _formatDateRange(String start, String end) {
    try {
      final startDate = DateTime.parse(start);
      final endDate = DateTime.parse(end);
      return '${startDate.day}/${startDate.month}/${startDate.year} - ${endDate.day}/${endDate.month}/${endDate.year}';
    } catch (_) {
      return '$start - $end';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Order List',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.blue,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.blue),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NotificationPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Order>>(
        future: _futureOrders,
        builder: (context, orderSnapshot) {
          if (orderSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (orderSnapshot.hasError) {
            return Center(child: Text('Error: \\${orderSnapshot.error}'));
          } else if (!orderSnapshot.hasData || orderSnapshot.data!.isEmpty) {
            return const Center(child: Text('No orders found.'));
          }
          return FutureBuilder<List<product_model.Product>>(
            future: _futureProducts,
            builder: (context, productSnapshot) {
              if (productSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (productSnapshot.hasError) {
                return Center(child: Text('Error: \\${productSnapshot.error}'));
              } else if (!productSnapshot.hasData || productSnapshot.data!.isEmpty) {
                return const Center(child: Text('No products found.'));
              }
              final orders = orderSnapshot.data!;
              final products = productSnapshot.data!;
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 10, 12, 4),
                    child: SizedBox(
                      height: 38,
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: 'Search orders...',
                          prefixIcon: Icon(Icons.search, size: 20),
                          contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          isDense: true,
                        ),
                        style: const TextStyle(fontSize: 14),
                        onChanged: (value) {
                          setState(() {
                            _searchQuery = value.toLowerCase();
                          });
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Builder(
                      builder: (context) {
                        final filteredOrders = _customerId == null
                            ? []
                            : orders
                                .where((order) => order.customerId == _customerId)
                                .where((order) {
                                  final product = products.firstWhere(
                                    (p) => (p as product_model.Product).id == order.productId,
                                    orElse: () => product_model.Product(
                                      id: 0,
                                      name: 'Unknown',
                                      description: '',
                                      rentPrice: 0,
                                      stock: 0,
                                      maxRentDay: 0,
                                      storage: '-',
                                      color: '-',
                                      imageUrl: '',
                                      partner: product_model.Partner(id: 0, name: '-'),
                                    ),
                                  );
                                  final name = product.name.toLowerCase();
                                  final status = order.status.toLowerCase();
                                  final price = order.totalPrice.toString();
                                  final duration = order.duration.toString();
                                  final startDate = order.startDate.toLowerCase();
                                  return _searchQuery.isEmpty ||
                                      name.contains(_searchQuery) ||
                                      status.contains(_searchQuery) ||
                                      price.contains(_searchQuery) ||
                                      duration.contains(_searchQuery) ||
                                      startDate.contains(_searchQuery);
                                })
                                .toList()
                                ..sort((a, b) => DateTime.parse(b.startDate).compareTo(DateTime.parse(a.startDate)));
                        if (_customerId == null) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        if (filteredOrders.isEmpty) {
                          return const Center(child: Text('No orders found for this customer.'));
                        }
                        return ListView.separated(
                          itemCount: filteredOrders.length,
                          separatorBuilder: (context, index) => const SizedBox.shrink(),
                          itemBuilder: (context, index) {
                            final order = filteredOrders[index];
                            final product = products.firstWhere(
                              (p) => (p as product_model.Product).id == order.productId,
                              orElse: () => product_model.Product(
                                id: 0,
                                name: 'Unknown',
                                description: '',
                                rentPrice: 0,
                                stock: 0,
                                maxRentDay: 0,
                                storage: '-',
                                color: '-',
                                imageUrl: '',
                                partner: product_model.Partner(id: 0, name: '-'),
                              ),
                            );
                            Color statusColor;
                            switch (order.status.toLowerCase()) {
                              case 'cancelled':
                                statusColor = Colors.red;
                                break;
                              case 'waiting':
                                statusColor = Colors.grey;
                                break;
                              case 'ready':
                                statusColor = Colors.blue;
                                break;
                              case 'rented':
                                statusColor = Colors.green;
                                break;
                              case 'return_now':
                                statusColor = Colors.yellow[700]!;
                                break;
                              case 'finished':
                                statusColor = Colors.white;
                                break;
                              default:
                                statusColor = Colors.grey;
                            }
                            return Container(
                              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.1),
                                    spreadRadius: 1,
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Main info column (date above image+info)
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          // Start and End Date above
                                          Text(
                                            _formatDateRange(order.startDate, order.endDate),
                                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: Colors.blue),
                                          ),
                                          const SizedBox(height: 8),
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              // Product Image
                                              ClipRRect(
                                                borderRadius: BorderRadius.circular(8),
                                                child: product.imageUrl.isNotEmpty
                                                    ? Image.network(
                                                        product.imageUrl,
                                                        width: 60,
                                                        height: 60,
                                                        fit: BoxFit.cover,
                                                        errorBuilder: (context, error, stackTrace) {
                                                          return Container(
                                                            width: 60,
                                                            height: 60,
                                                            color: Colors.grey[300],
                                                            alignment: Alignment.center,
                                                            child: const Text(
                                                              'order data failed to get fetched',
                                                              style: TextStyle(fontSize: 10, color: Colors.red),
                                                              textAlign: TextAlign.center,
                                                            ),
                                                          );
                                                        },
                                                      )
                                                    : Container(
                                                        width: 60,
                                                        height: 60,
                                                        color: Colors.grey[300],
                                                        child: const Icon(Icons.broken_image, size: 32, color: Colors.grey),
                                                      ),
                                              ),
                                              const SizedBox(width: 12),
                                              // Product Info
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      product.name,
                                                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                    const SizedBox(height: 4),
                                                    Text('Duration: ${order.duration} day(s)', style: const TextStyle(fontSize: 12)),
                                                    const SizedBox(height: 4),
                                                    Text('Total: Rp${order.totalPrice.toStringAsFixed(0)}', style: const TextStyle(fontSize: 12)),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    // Status
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            final status = order.status.toLowerCase();
                                            if (status == 'ready' || status == 'rented') {
                                              _showPickupInfoDialog(context, order);
                                            } else if (status == 'return_now') {
                                              _showReturnNowInfoDialog(context, order);
                                            } else if (status == 'finished') {
                                              _showFinishedInfoDialog(context, order);
                                            }
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                                            decoration: BoxDecoration(
                                              color: (order.status.toLowerCase() == 'return_now')
                                                  ? Colors.yellow[700]!.withOpacity(0.2)
                                                  : statusColor.withOpacity(order.status.toLowerCase() == 'finished' ? 0.7 : 0.1),
                                              borderRadius: BorderRadius.circular(8),
                                              border: order.status.toLowerCase() == 'finished' ? Border.all(color: Colors.grey) : null,
                                            ),
                                            child: Text(
                                              order.status.toLowerCase() == 'return_now'
                                                  ? 'return now'
                                                  : order.status,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: (order.status.toLowerCase() == 'return_now')
                                                    ? Colors.yellow[800]
                                                    : (order.status.toLowerCase() == 'finished' ? Colors.black : statusColor),
                                                fontSize: 12,
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
                          },
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
      bottomNavigationBar: MainBottomNav(
        currentIndex: 1, // Transaksi is the 2nd item (index 1)
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ProductPage()),
            );
          } else if (index == 1) {
            // Already on OrderListPage
          } else if (index == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ProfilePage()),
            );
          }
        },
      ),
    );
  }
}
