// isinya nanti menyimpan data sewa dan statusnya. (masih kurang ngerti bedanya sama sewa.dart)
import 'package:flutter/foundation.dart';
import '../models/sewa.dart';

class TransactionProvider with ChangeNotifier {
  final List<Transaction> _transactions = [];

  List<Transaction> get transactions => List.unmodifiable(_transactions);

  void addTransaction(Transaction transaction) {
    _transactions.add(transaction);
    notifyListeners();
  }
}