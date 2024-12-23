import 'package:dogs/shared/palette.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData themeData = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Palette.primary,
  ),
  useMaterial3: true,
).copyWith(
  textTheme: GoogleFonts.nunitoTextTheme(),
);
