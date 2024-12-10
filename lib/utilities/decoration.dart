import 'package:flutter/material.dart';
import 'package:flutter_application_5/utilities/fonts_dart.dart';
import 'package:provider/provider.dart';
import '../utilities/theme_provider.dart';

InputDecoration customInputDecoration(String labelText, BuildContext context) {
  // Check if dark mode is enabled
  final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

  return InputDecoration(
    filled: true,
    labelText: labelText,
    labelStyle: isDarkMode ? AppFonts.textW24bold : AppFonts.textB24bold,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Colors.transparent),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Colors.transparent),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Colors.transparent),
    ),
  );
}

// Function for Container decoration
BoxDecoration customContainerDecoration({
  Color color = Colors.cyan,
  double borderRadius = 5.0,
  required BuildContext context, // Pass BuildContext to check for dark mode
}) {
  // Check if dark mode is enabled
  final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

  return BoxDecoration(
    color: isDarkMode ? Colors.grey[800]! : color, // Modify color based on theme
    borderRadius: BorderRadius.circular(borderRadius),
  );
}
