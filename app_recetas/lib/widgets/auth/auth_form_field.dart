import 'package:flutter/material.dart';

class AuthFormField extends StatelessWidget {
  final String label;
  final bool obscureText;
  final double scale;
  final TextEditingController? controller;

  const AuthFormField({
    Key? key,
    required this.label,
    this.obscureText = false,
    this.scale = 1.0,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 14 * scale, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4 * scale),
        Container(
          color: Color(0xFF4F5D75),
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            style: TextStyle(fontSize: 14 * scale, color: Colors.white),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 12 * scale,
                vertical: 10 * scale,
              ),
              isDense: true,
            ),
          ),
        ),
      ],
    );
  }
}
