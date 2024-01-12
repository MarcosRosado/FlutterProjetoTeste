import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final defaultTheme = _buildDefaultTheme();

ThemeData _buildDefaultTheme(){
  return ThemeData(
    useMaterial3: true,
    fontFamily: GoogleFonts.montserrat().fontFamily,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.cyan,
      brightness: Brightness.light,
    ),
  );
}