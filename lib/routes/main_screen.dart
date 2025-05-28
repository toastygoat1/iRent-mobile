import 'package:flutter/material.dart';
import '../pages/detail_page.dart';
import '../pages/home_page.dart';
import '../pages/transaksi_page.dart';
import '../widgets/main_bottom_nav.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _onTap(int index) {
    _pageController.jumpToPage(index); // Bisa juga pakai animateToPage
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: const [
          HomePage(),
          TransactionPage(),
        ],
        physics: const NeverScrollableScrollPhysics(), // Nonaktifkan swipe jika mau eksklusif lewat nav
      ),
      bottomNavigationBar: MainBottomNav(
        currentIndex: _currentIndex,
        onTap: _onTap,
      ),
    );
  }
}


