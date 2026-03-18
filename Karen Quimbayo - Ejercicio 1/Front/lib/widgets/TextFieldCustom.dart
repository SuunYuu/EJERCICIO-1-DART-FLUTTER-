// ognore

import 'package:flutter/material.dart';

import '../utils/Global.colors.dart';

class TextFieldCustom extends StatelessWidget {
  final TextInputType type;
  final IconData icon;
  final Color appColor = GlobalColors.secondaryBtnColor;
  final bool pass;
  final String label;
  final String hint;
  final double radius = 50;
  final TextEditingController? controller;

  TextFieldCustom({
    required this.type,
    required this.icon,
    super.key,
    required this.label,
    required this.hint,
    this.pass = false,
    this.controller,
  });
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TextField(
      controller: controller,
      keyboardType: type,
      obscureText: pass,
      decoration: InputDecoration(
        prefix: Icon(icon, color: GlobalColors.mediumColorH),
        labelText: label,
        hintText: hint,
        filled: true,
        fillColor: GlobalColors.lightColor,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: GlobalColors.lightColorH),
          borderRadius: BorderRadius.all(Radius.circular(radius)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: GlobalColors.mediumColor),
          borderRadius: BorderRadius.all(Radius.circular(radius)),
        ),
      ),
    );
  }
}
