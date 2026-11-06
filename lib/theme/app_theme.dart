import 'package:flutter/material.dart';

class AppTheme {
  // الألوان الرئيسية للتصميم الإسلامي الزمردي والذهبي
  static const Color primaryGreen = Color(0xFF0F5132);
  static const Color secondaryGreen = Color(0xFF137547);
  static const Color accentGold = Color(0xFFD4AF37);
  static const Color lightGold = Color(0xFFF3E5AB);
  static const Color darkBackground = Color(0xFF0D1F17);
  static const Color lightBackground = Color(0xFFF5F7F5);
  static const Color cardLight = Colors.white;
  static const Color cardDark = Color(0xFF162D22);
  static const Color textDark = Color(0xFF1C2D24);
  static const Color textLight = Color(0xFFF5F7F5);
  static const Color textMuted = Color(0xFF6C757D);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: primaryGreen,
      scaffoldBackgroundColor: lightBackground,
      colorScheme: const ColorScheme.light(
        primary: primaryGreen,
        secondary: accentGold,
        surface: cardLight,
        background: lightBackground,
        onPrimary: Colors.white,
        onSecondary: textDark,
        onSurface: textDark,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 2,
        iconTheme: IconThemeData(color: accentGold),
        titleTextStyle: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontFamily: 'Roboto',
        ),
      ),
      cardTheme: CardTheme(
        color: cardLight,
        elevation: 3,
        shadowColor: primaryGreen.withOpacity(0.15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: accentGold.withOpacity(0.3), width: 1),
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: primaryGreen,
        selectedItemColor: accentGold,
        unselectedItemColor: Colors.white60,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryGreen,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          elevation: 4,
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: accentGold,
        foregroundColor: primaryGreen,
        elevation: 6,
      ),
    );
  }
}
