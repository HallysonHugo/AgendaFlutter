import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class CustomTextField extends StatelessWidget {
  final EdgeInsetsGeometry? margin;
  final Widget? label;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final Widget? prefix;
  final bool obscureText;
  final Widget? suffixIcon;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  const CustomTextField({super.key, this.margin, this.label, this.controller, this.onChanged, 
    this.prefix, this.obscureText = false, this.suffixIcon, this.inputFormatters, this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: TextField(
        obscureText: obscureText,
        onChanged: onChanged,
        inputFormatters: inputFormatters,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          prefixIcon: prefix,
          label: label,
          border: const OutlineInputBorder(),
        ),
        controller: controller,
      ),
    );
  }
}