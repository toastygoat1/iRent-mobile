class Transaction {
  final String productName;
  final int quantity;
  final int totalPrice;
  final String date;
  final String status;
  final String imageUrl;

  Transaction({
    required this.productName,
    required this.quantity,
    required this.totalPrice,
    required this.date,
    required this.status,
    required this.imageUrl,
  });
}

