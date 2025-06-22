import 'package:flutter/material.dart';
import 'package:irent/pages/login_page.dart'; // Tambahkan ini
import 'package:irent/pages/order_list_page.dart';
import 'package:irent/pages/product_page.dart';
import 'package:irent/pages/profile_page.dart';
import 'package:irent/viewmodels/sewa_viewmodels.dart';
import 'package:provider/provider.dart';



void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => TransactionProvider())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      initialRoute: '/login',
      // Ubah initialRoute
      routes: {
        '/login': (context) => const LoginPage(),
        '/': (context) => const ProductPage(),
        '/profile': (context) => const ProfilePage(),
        '/transactions': (context) => const OrderListPage(),
      },
    );
  }
}
