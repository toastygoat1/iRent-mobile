import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/order.dart';

class OrderService {
  static const String baseUrl = 'http://10.0.2.2:8000/api';

  Future<List<Order>> fetchOrders() async {
    final response = await http.get(Uri.parse('$baseUrl/orders'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonBody = json.decode(response.body);
      final List<dynamic> data = jsonBody['data'];
      return data.map((json) => Order.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load orders');
    }
  }
}

