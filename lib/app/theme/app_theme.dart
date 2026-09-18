
import 'package:flutter/material.dart';

class AppTheme {
  // 🎨 Brand Colors
  static const Color primaryColor = Color(0xFFFD746C);
  static const Color primaryDark = Color(0xFF2C3E50);
  static const Color primaryLight = Color(0xFFFFE2E0);
  static const Color secondaryColor = Color(0xFFFF9A8F);
  static const Color backgroundColor = Color(0xFFF8F9FC);

  // Additional Colors
  static const Color white = Colors.white;
  static const Color textPrimary = Color(0xFF2C3E50);
  static const Color textSecondary = Color(0xFF7F8C8D);
  static const Color borderColor = Color(0xFFEAECEF);

  // 🌞 Light Theme
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,

    brightness: Brightness.light,

    // Primary Colors
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      brightness: Brightness.light,
      primary: primaryColor,
      secondary: secondaryColor,
      surface: white,
    ),

    scaffoldBackgroundColor: backgroundColor,

    // App Bar Theme
    appBarTheme: const AppBarTheme(
      backgroundColor: backgroundColor,
      foregroundColor: primaryDark,
      elevation: 0,
      centerTitle: false,
      surfaceTintColor: Colors.transparent,
      titleTextStyle: TextStyle(
        color: primaryDark,
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
    ),

    // Text Theme
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        color: primaryDark,
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: TextStyle(
        color: primaryDark,
        fontSize: 28,
        fontWeight: FontWeight.bold,
      ),
      headlineLarge: TextStyle(
        color: primaryDark,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: TextStyle(
        color: primaryDark,
        fontSize: 20,
        fontWeight: FontWeight.w700,
      ),
      titleLarge: TextStyle(
        color: primaryDark,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
      titleMedium: TextStyle(
        color: primaryDark,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: TextStyle(
        color: primaryDark,
        fontSize: 16,
      ),
      bodyMedium: TextStyle(
        color: textSecondary,
        fontSize: 14,
      ),
      bodySmall: TextStyle(
        color: textSecondary,
        fontSize: 12,
      ),
    ),

    // Cards
    cardTheme: CardThemeData(
      color: white,
      elevation: 0,
      margin: EdgeInsets.zero,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(
          color: borderColor,
          width: 1,
        ),
      ),
    ),

    // Elevated Buttons
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 16,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),

    // Floating Action Button
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
      foregroundColor: white,
      elevation: 2,
    ),

    // Input Fields
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: white,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: borderColor,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: borderColor,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: primaryColor,
          width: 2,
        ),
      ),
    ),

    // Bottom Navigation Bar
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: white,
      elevation: 0,
      indicatorColor: primaryLight,
      labelTextStyle: WidgetStateProperty.resolveWith(
        (states) {
          if (states.contains(WidgetState.selected)) {
            return const TextStyle(
              color: primaryColor,
              fontWeight: FontWeight.w600,
            );
          }

          return const TextStyle(
            color: textSecondary,
          );
        },
      ),
      iconTheme: WidgetStateProperty.resolveWith(
        (states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(
              color: primaryColor,
            );
          }

          return const IconThemeData(
            color: textSecondary,
          );
        },
      ),
    ),

    // Divider
    dividerTheme: const DividerThemeData(
      color: borderColor,
      thickness: 1,
      space: 1,
    ),
  );
}
