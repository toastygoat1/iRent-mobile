import 'package:shared_preferences/shared_preferences.dart';

class CustomerUtils {
  static Future<int?> getCustomerId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('customer_id');
  }
}

