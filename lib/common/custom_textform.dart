import 'package:flutter/material.dart';
import 'package:medi_mate/constants.dart';

/// A custom text input field with customizable features.
class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.textController,
    required this.fieldKey,
    this.isDisabled = false,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.autofillHints,
    this.textInputAction = TextInputAction.done,
    required this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.maxLines = 1,
    this.minLines,
    this.enabled = true,
  });

  final TextEditingController textController;
  final GlobalKey<FormFieldState> fieldKey;
  final bool isDisabled;
  final String hintText;
  final TextInputType keyboardType;
  final List<String>? autofillHints;
  final TextInputAction textInputAction;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final int maxLines;
  final int? minLines;
  final bool? enabled;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        controller: textController,
        decoration: _buildInputDecoration(),
        key: fieldKey,
        style: const TextStyle(color: Colors.black),
        enabled: !isDisabled,
        keyboardType: keyboardType,
        autofillHints: autofillHints,
        textInputAction: textInputAction,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: validator,
        obscureText: obscureText,
        maxLines: maxLines,
        minLines: minLines,
      ),
    );
  }

  /// Builds input decoration for the text field.
  InputDecoration _buildInputDecoration() {
    return InputDecoration(
      hintStyle: const TextStyle(color: Colors.grey),
      hintText: hintText,
      filled: true,
      fillColor: kPrimaryColor.withOpacity(0.1),
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide.none,
      ),
      contentPadding:
          const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
    );
  }
}
