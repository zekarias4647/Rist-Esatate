import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:user_auth_frontend/screens/auth/waiting_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  final _formKey = GlobalKey<FormState>();
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;
  late TextEditingController _phoneController;
  String? _selectedRole;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    _animationController.forward();

    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _phoneController = TextEditingController();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: Scaffold(
        backgroundColor: const Color(0xFFE0E5EC), // Light gray background color
        body: Center(
          child: Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Image.asset(
                      'assets/images/logos/photo_2023-09-18_23-26-50__2_-re.png', // Replace this with your company logo asset path
                      width: 200, // Adjust the width as needed
                      height: 150, // Adjust the height as needed
                    ),
                    const Text(
                      'Sign Up',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF005A8D), // Teal title color
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildTextFormField(
                      controller: _firstNameController,
                      labelText: 'First Name',
                      prefixIcon: Icons.person,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your first name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    _buildTextFormField(
                      controller: _lastNameController,
                      labelText: 'Last Name',
                      prefixIcon: Icons.person,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your last name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    _buildTextFormField(
                      controller: _emailController,
                      labelText: 'Email',
                      prefixIcon: Icons.email,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    _buildTextFormField(
                      controller: _passwordController,
                      labelText: 'Password',
                      prefixIcon: Icons.lock,
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    _buildTextFormField(
                      controller: _confirmPasswordController,
                      labelText: 'Confirm Password',
                      prefixIcon: Icons.lock,
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please confirm your password';
                        } else if (value != _passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    _buildTextFormField(
                      controller: _phoneController,
                      labelText: 'Phone',
                      prefixIcon: Icons.phone,
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please confirm your password';
                        } else if (value != _passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    DropdownButtonFormField<String>(
                      value: _selectedRole,
                      onChanged: (value) {
                        setState(() {
                          _selectedRole = value;
                        });
                      },
                      items: [
                        const DropdownMenuItem(
                          value: 'agent',
                          child: Text('Agent'),
                        ),
                        const DropdownMenuItem(
                          value: 'agency',
                          child: Text('Agency'),
                        ),
                        const DropdownMenuItem(
                          value: 'owner',
                          child: Text('Owner'),
                        ),
                        const DropdownMenuItem(
                          value: 'buyer',
                          child: Text('Buyer'),
                        ),
                        const DropdownMenuItem(
                          value: 'seller',
                          child: Text('Seller'),
                        ),
                        const DropdownMenuItem(
                          value: 'manager',
                          child: Text('Manager'),
                        ),
                      ],
                      decoration: InputDecoration(
                        labelText: 'Role',
                        prefixIcon: const Icon(Icons.person_outline),
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      validator: (value) {
                        if (value == null) {
                          return 'Please select your role';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        print('Signing up...');
                        print('First Name: ${_firstNameController.text}');
                        print('Last Name: ${_lastNameController.text}');
                        print('Email: ${_emailController.text}');
                        print('Password: ${_passwordController.text}');
                        print('Phone: ${_phoneController.text}');
                        print('Role: $_selectedRole');

                        // Process sign up
                        signUp(
                          _firstNameController.text,
                          _lastNameController.text,
                          _emailController.text,
                          _passwordController.text,
                          _confirmPasswordController.text,
                          _phoneController.text,
                          _selectedRole!,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color(0xFF005A8D), // Teal button color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: () {
                        // Navigate to the sign-in page
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Already have an account? Sign In',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF005A8D), // Teal color
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> signUp(String firstName, String lastName, String email,
      String password, String phone, String role, String confpassword) async {
    final url = Uri.parse('http://localhost:3000/register');
    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'firstname': firstName,
          'lastname': lastName,
          'email': email,
          'password': password,
          'confpassword': confpassword,
          'phone': phone,
          'role': role,
        }),
      );
      if (response.statusCode == 201) {
        print('User signed up successfully');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  WaitingPage()), // Replace SuccessPage() with your actual success page widget
        );
      } else {
        print(
            'Failed to sign up. Server responded with status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error signing up: $e');
    }
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String labelText,
    IconData? prefixIcon,
    bool obscureText = false,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: prefixIcon != null
            ? Icon(prefixIcon, color: const Color(0xFF005A8D))
            : null,
        filled: true,
        fillColor: const Color(0xFFDCE5EA),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
      validator: validator,
    );
  }
}
