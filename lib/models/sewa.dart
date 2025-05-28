// isinya nanti data penyewaan (tanggal, durasi, status)
class Transaction {
  final String productName;
  final int quantity;
  final int totalPrice;
  final String date;
  final String status;

  Transaction({
    required this.productName,
    required this.quantity,
    required this.totalPrice,
    required this.date,
    required this.status,
  });
}
