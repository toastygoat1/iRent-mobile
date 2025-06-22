// lib/pages/profile_page.dart (or your existing path)
import 'package:flutter/material.dart';
import 'package:irent/pages/login_page.dart'; // Import your LoginPage
import 'package:irent/widgets/main_bottom_nav.dart'; // Assuming you have this for consistency
import 'package:shared_preferences/shared_preferences.dart';
import 'package:irent/pages/notification_page.dart'; // Import your NotificationPage
import 'package:irent/pages/product_page.dart'; // Import ProductPage
import 'package:irent/pages/order_list_page.dart'; // Import OrderListPage

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? _userName;
  String? _userEmail;
  bool _isLoading = true; // To show a loader while fetching data

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userName = prefs.getString('userName');
      _userEmail = prefs.getString('userEmail');
      _isLoading = false;
    });
  }

  Future<void> _handleLogout() async {
    final prefs = await SharedPreferences.getInstance();
    // Clear stored user data and token
    await prefs.remove('userName');
    await prefs.remove('userEmail');
    await prefs.remove('apiToken'); // Make sure to remove the token as well

    print('User logged out, session data cleared.');

    // Navigate back to LoginPage and remove all previous routes
    if (mounted) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const LoginPage()),
        (Route<dynamic> route) =>
            false, // This predicate always returns false, so all routes are removed
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Saya'),
        automaticallyImplyLeading:
            false, // Optional: remove back button if using bottom nav
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
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
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                // Center the content
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // Center vertically
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // Center horizontally
                  children: <Widget>[
                    const CircleAvatar(
                      radius: 50,
                      child: Icon(Icons.person, size: 50), // Placeholder icon
                    ),
                    const SizedBox(height: 24),
                    Text(
                      _userName ?? 'Nama Pengguna Tidak Tersedia',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _userEmail ?? 'Email Tidak Tersedia',
                      style: const TextStyle(fontSize: 16, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 40),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.logout),
                      label: const Text('Logout'),
                      onPressed: _handleLogout,
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Colors.red, // Or your theme's error color
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 15,
                        ),
                        textStyle: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
      bottomNavigationBar: MainBottomNav(
        currentIndex: 2, // Profile is the 3rd item (index 2)
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ProductPage()),
            );
          } else if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => OrderListPage()),
            );
          }
          // If index is 2, we are already on the Profile page
        },
      ),
    );
  }
}
