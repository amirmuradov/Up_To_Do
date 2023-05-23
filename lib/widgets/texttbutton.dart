import 'package:flutter/material.dart';

class Textbutton extends StatelessWidget {
  const Textbutton({super.key, required this.icon});
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 100),
      child: Container(
        height: 55,
        width: 160,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 89, 92, 255),
          borderRadius: BorderRadius.circular(7),
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 45,
        ),
      ),
    );
  }
}
