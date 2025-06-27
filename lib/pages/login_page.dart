import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:irent/pages/product_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  static const String _baseUrl =
      'http://10.0.2.2:8000/api'; // Common for Android Emulator

  bool _isLoading = false;
  String? _errorMessage;

  // Dispose controllers when the widget is removed from the widget tree
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _saveCustomerId(int customerId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('customer_id', customerId);
  }

  void _login() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email dan password wajib diisi')),
      );
      return;
    }

    // Actual login logic: send request to API and get customer id from response
    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:8000/api/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );
      final responseData = jsonDecode(response.body);
      if (response.statusCode == 200 &&
          responseData['user'] != null &&
          responseData['user']['id'] != null) {
        int customerId = responseData['user']['id'];
        await _saveCustomerId(customerId);
        Navigator.pushReplacementNamed(context, '/');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(responseData['message'] ?? 'Login gagal.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login error: \\${e.toString()}')),
      );
    }
  }

  void _goToSignUp() {
    // Ganti dengan navigator ke halaman SignUp jika sudah ada
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Navigasi ke halaman Sign Up')),
    );
    // Navigator.pushNamed(context, '/signup');
  }

  Future<void> _handleLogin() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      try {
        final response = await http.post(
          Uri.parse('$_baseUrl/login'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Accept': 'application/json',
          },
          body: jsonEncode(<String, String>{
            'email': _emailController.text.trim(),
            'password': _passwordController.text.trim(),
            'device_name': 'flutter_android_app',
          }),
        );

        final responseData = jsonDecode(response.body);

        if (response.statusCode == 200) {
          // Check if user is a customer
          if (responseData['user'] != null &&
              responseData['user']['role'] == 'customer') {  // Add role check
            final prefs = await SharedPreferences.getInstance();

            // Save user data
            await prefs.setString(
              'userName',
              responseData['user']['name'] ?? 'N/A',
            );
            await prefs.setString(
              'userEmail',
              responseData['user']['email'] ?? 'N/A',
            );
            if (responseData['user']['id'] != null) {
              await prefs.setInt('customer_id', responseData['user']['id']);
            }
            if (responseData['token'] != null) {
              await prefs.setString('apiToken', responseData['token']);
            }

            if (mounted) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const ProductPage()),
              );
            }
          } else {
            // User is not a customer
            setState(() {
              _errorMessage = 'Access denied. Only customers can login.';
            });
          }
        } else if (response.statusCode == 401) {
          setState(() {
            _errorMessage = responseData['message'] ?? 'Invalid email or password.';
          });
        } else {
          setState(() {
            _errorMessage = 'An error occurred. Please try again.';
          });
        }
      } catch (e) {
        setState(() {
          _errorMessage = 'Network error. Please check your connection.';
        });
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            // 1. Wrap with Form widget
            key: _formKey, // Assign the GlobalKey
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // iRent di tengah atas
                Center(
                  child: Column(
                    children: const [
                      SizedBox(height: 150),
                      Text(
                        'iRent',
                        style: TextStyle(
                          fontSize: 64,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 50),
                const Text(
                  'Login',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),

                // Email TextFormField
                TextFormField(
                  // 2. Change to TextFormField
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    // 3. Add validator
                    if (value == null || value.isEmpty) {
                      return 'Email wajib diisi';
                    }
                    if (!value.contains('@') || !value.contains('.')) {
                      return 'Masukkan format email yang valid';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Password TextFormField
                TextFormField(
                  // 2. Change to TextFormField
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    // 3. Add validator
                    if (value == null || value.isEmpty) {
                      return 'Password wajib diisi';
                    }
                    // You might want to add more password validation rules here
                    return null;
                  },
                ),
                const SizedBox(height: 20), // Reduced height for error message
                // Error Message Display
                if (_errorMessage != null) // 5. Display error message
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      _errorMessage!,
                      style: const TextStyle(color: Colors.red, fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                  ),

                const SizedBox(height: 10), // Space before login button
                // Tombol login
                _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      ) // 6. Show loading indicator
                    : GestureDetector(
                        onTap: _handleLogin, // 4. Call _handleLogin
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            'Login',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
