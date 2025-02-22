import 'package:dogs/shared/palette.dart';
import 'package:flutter/material.dart';

class InputStyle {
  static OutlineInputBorder inputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(
      width: 2,
      color: Palette.primary,
      style: BorderStyle.solid,
    ),
  );

  static OutlineInputBorder inputBorderSearch = OutlineInputBorder(
    borderRadius: BorderRadius.circular(30),
    gapPadding: 10,
    borderSide: const BorderSide(
      width: 2,
      color: Palette.white,
      style: BorderStyle.solid,
    ),
  );
}
