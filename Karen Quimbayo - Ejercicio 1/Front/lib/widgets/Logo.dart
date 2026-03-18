// ignore_for_file: file_names
import 'package:flutter/material.dart';

class LogoHeader extends StatelessWidget {
  const LogoHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 80,
      left: MediaQuery.of(context).size.width * 0.38,
      child: Container(
        height: 80,
        width: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50),
          boxShadow: const [
            BoxShadow(blurRadius: 10, color: Colors.black26)
          ]),
        child: const Align(
          alignment: Alignment.center,
          child: Text(
            'Frave',
            style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
          ),
        ),
      )
    );
  }
}
