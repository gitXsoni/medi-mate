import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'forgot_password.dart';
import 'pages/home_page.dart';
import 'pages/register_page.dart';
import 'common/custom_elevated_button.dart';
import 'common/custom_textform.dart';
import 'constants.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State <LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState> emailKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> passwordKey = GlobalKey<FormFieldState>();
  bool _isPasswordVisible = false;

  Future<void> _login() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedEmail = prefs.getString('email');
    String? storedName = prefs.getString('name');
    String? storedPassword = prefs.getString('password');
   await clearMedicineData();
    if (_emailController.text == storedEmail || _emailController.text == storedName  &&
        _passwordController.text == storedPassword) {
      await prefs.setBool('isLoggedIn', true);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Invalid email or password'),
      ));
    }
  }

  Future<void> clearMedicineData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('medicines');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Welcome Back !",
                  style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 10),
              Text("Login to an existing account to continue",
                  style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 40),
              CustomTextField(
                hintText: "Email",
                textController: _emailController,
                fieldKey: emailKey,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              CustomTextField(
                hintText: "Password",
                textController: _passwordController,
                fieldKey: passwordKey,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
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
                obscureText: !_isPasswordVisible,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ForgotPasswordPage()),
                    );
                  },
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(color: kPrimaryColor),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              CustomElevatedLoadingButton(
                height: MediaQuery.of(context).size.height * 0.04,
                width: MediaQuery.of(context).size.width,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _login();
                  }
                },
                child: const Text('Login'),
              ),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const RegisterPage()),
                    );
                  },
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Don\'t have an account?',
                        style: TextStyle(color: Colors.black),
                      ),
                      SizedBox(width: 5),
                      Text(
                        'Register',
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
