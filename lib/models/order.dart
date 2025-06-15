class Customer {
  final int id;
  final String name;

  Customer({required this.id, required this.name});

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'],
      name: json['name'],
    );
  }
}

class Partner {
  final int id;
  final String name;

  Partner({required this.id, required this.name});

  factory Partner.fromJson(Map<String, dynamic> json) {
    return Partner(
      id: json['id'],
      name: json['name'],
    );
  }
}

class Order {
  final int id;
  final int customerId;
  final int productId;
  final int partnerId;
  final String startDate;
  final String endDate;
  final int duration;
  final double totalPrice;
  final String status;
  final Customer customer;
  final Partner partner;

  Order({
    required this.id,
    required this.customerId,
    required this.productId,
    required this.partnerId,
    required this.startDate,
    required this.endDate,
    required this.duration,
    required this.totalPrice,
    required this.status,
    required this.customer,
    required this.partner,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      customerId: json['customer_id'],
      productId: json['product_id'],
      partnerId: json['partner_id'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      duration: json['duration'],
      totalPrice: double.tryParse(json['total_price'].toString()) ?? 0.0,
      status: json['status'],
      customer: Customer.fromJson(json['customer']),
      partner: Partner.fromJson(json['partner']),
    );
  }
}

