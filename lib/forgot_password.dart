import 'package:flutter/material.dart';
import 'package:medi_mate/common/custom_textform.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
State   <ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState> emailKey = GlobalKey<FormFieldState>();

  Future<void> _sendPasswordResetEmail() async {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Password reset link sent to ${_emailController.text}'),
      ));
    }
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextField(
                hintText: 'Email',
                textController: _emailController,
                validator: _validateEmail,
                fieldKey: emailKey,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _sendPasswordResetEmail,
                child: const Text('Send Reset Link'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
