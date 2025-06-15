import 'package:flutter/material.dart';
import '../models/order.dart';
import '../models/product.dart' as product_model;
import '../services/order_service.dart';
import '../services/product_service.dart';

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

  @override
  void initState() {
    super.initState();
    _futureOrders = _orderService.fetchOrders();
    _futureProducts = _productService.fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Order List')),
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
              return ListView.separated(
                itemCount: orders.length,
                separatorBuilder: (context, index) => const SizedBox.shrink(), // Remove horizontal line
                itemBuilder: (context, index) {
                  final order = orders[index];
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
                                // Start Date above
                                Text(
                                  order.startDate != null
                                      ? (order.startDate is DateTime
                                          ? (order.startDate as DateTime).toString().split(' ')[0]
                                          : order.startDate.toString().split(' ')[0])
                                      : '-',
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.blue),
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
                              Container(
                                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                                decoration: BoxDecoration(
                                  color: Colors.blue.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Text(
                                  'waiting',
                                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue, fontSize: 12),
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
          );
        },
      ),
    );
  }
}
