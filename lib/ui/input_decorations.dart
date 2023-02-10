import 'package:flutter/material.dart';

class InputDecorations {
  static InputDecoration authInputDecoration({
    required String hintText,
    required String labelText,
    IconData? prefixIcon,
    required Color color,
  }) {
    return InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      labelText: labelText,
      labelStyle: TextStyle(color: color),
      hintText: hintText,
      prefixIcon: prefixIcon != null
          ? Icon(
              prefixIcon,
              color: color,
            )
          : null,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
    );
  }
}
