import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTheme{
  static ThemeData themeData({required BuildContext context}){
    return ThemeData(
      textTheme: GoogleFonts.ralewayTextTheme(
        Theme.of(context).textTheme,
      ),
    );
  }
}