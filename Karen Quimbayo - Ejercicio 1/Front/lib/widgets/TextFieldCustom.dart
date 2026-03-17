// lib/widgets/TextFieldCustom.dart (modificado)
import 'package:flutter/material.dart';

class TextFieldCustom extends StatelessWidget {
  final TextInputType type;
  final IconData icon;
  final String label;
  final String hint;
  final bool pass;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  const TextFieldCustom({
    super.key,
    required this.type,
    required this.icon,
    required this.label,
    required this.hint,
    this.pass = false,
    this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: pass,
      validator: validator,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        fillColor: Colors.grey[100],
      ),
    );
  }
}