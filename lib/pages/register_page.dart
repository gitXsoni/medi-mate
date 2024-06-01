import 'package:flutter/material.dart';
import 'package:medi_mate/common/custom_textform.dart';
import 'package:medi_mate/constants.dart';
import 'package:medi_mate/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common/custom_elevated_button.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State <RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState> username = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> email = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> password = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> confirmPassword = GlobalKey<FormFieldState>();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  Future<void> _register() async {
    if (_formKey.currentState!.validate()) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('email', _emailController.text);
      await prefs.setString('name', _usernameController.text); 
      await prefs.setString('password', _passwordController.text);

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Registration successful'),
      ));

      Navigator.pop(context);
    }
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email';
    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a username';
    } else if (value.length < 4) {
      return 'Username must be at least 4 characters long';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    } else if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    } else if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Password must contain at least one uppercase letter';
    } else if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'Password must contain at least one lowercase letter';
    } else if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Password must contain at least one number';
    } else if (!RegExp(r'[!@#\$&*~]').hasMatch(value)) {
      return 'Password must contain at least one special character';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    } else if (value != _passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back_ios, size: 25),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Hello there !",
                  style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 10),
              Text("Create a new account to continue",
                  style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 40),
              CustomTextField(
                textController: _usernameController,
                hintText: 'Username',
                validator: _validateUsername,
                fieldKey: username,
              ),
              CustomTextField(
                hintText: 'Email',
                textController: _emailController,
                validator: _validateEmail,
                fieldKey: email,
              ),
              CustomTextField(
                textController: _passwordController,
                hintText: 'Password',
                fieldKey: password,
                obscureText: !_isPasswordVisible,
                validator: _validatePassword,
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
              ),
              CustomTextField(
                textController: _confirmPasswordController,
                hintText: 'Confirm Password',
                obscureText: !_isConfirmPasswordVisible,
                validator: _validateConfirmPassword,
                fieldKey: confirmPassword,
                suffixIcon: IconButton(
                  icon: Icon(
                    _isConfirmPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                    });
                  },
                ),
              ),
              const SizedBox(height: 20),
              CustomElevatedLoadingButton(
                height: MediaQuery.of(context).size.height * 0.04,
                width: MediaQuery.of(context).size.width,
                onPressed: _register,
                child: const Text('Register'),
              ),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginPage()),
                    );
                  },
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Already have an account?',
                        style: TextStyle(color: Colors.black),
                      ),
                      SizedBox(width: 5),
                      Text(
                        'Login',
                        style: TextStyle(color: kPrimaryColor),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
