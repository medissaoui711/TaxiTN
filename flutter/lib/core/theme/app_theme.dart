import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTheme {
  // Brand Colors
  static const Color primaryColor = Color(0xFF3DC56A);
  static const Color secondaryColor = Color(0xFF10B981);
  static const Color accentColor = Color(0xFF7C3AED);
  
  // Semantic Colors
  static const Color successColor = Color(0xFF10B981);
  static const Color errorColor = Color(0xFFEF4444);
  static const Color warningColor = Color(0xFFF59E0B);
  static const Color infoColor = Color(0xFF3B82F6);
  
  // Background Colors
  static const Color scaffoldBackgroundColor = Color(0xFFF8FAFC);
  static const Color cardColor = Colors.white;
  static const Color dividerColor = Color(0xFFE2E8F0);
  
  // Text Colors
  static const Color textPrimaryColor = Color(0xFF1E293B);
  static const Color textSecondaryColor = Color(0xFF64748B);
  static const Color textHintColor = Color(0xFF94A3B8);
  
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: scaffoldBackgroundColor,
      primaryColor: primaryColor,
      colorScheme: const ColorScheme.light(
        primary: primaryColor,
        secondary: secondaryColor,
        surface: cardColor,
        error: errorColor,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: textPrimaryColor,
        onError: Colors.white,
      ),
      fontFamily: 'Tajawal',
      textTheme: _textTheme,
      appBarTheme: _appBarTheme,
      elevatedButtonTheme: _elevatedButtonTheme,
      outlinedButtonTheme: _outlinedButtonTheme,
      textButtonTheme: _textButtonTheme,
      inputDecorationTheme: _inputDecorationTheme,
      cardTheme: _cardTheme,
      bottomNavigationBarTheme: _bottomNavigationBarTheme,
    );
  }
  
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF0F172A),
      primaryColor: primaryColor,
      colorScheme: const ColorScheme.dark(
        primary: primaryColor,
        secondary: secondaryColor,
        surface: Color(0xFF1E293B),
        error: errorColor,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: Colors.white,
        onError: Colors.white,
      ),
      fontFamily: 'Tajawal',
    );
  }
  
  // Text Theme
  static TextTheme get _textTheme {
    return TextTheme(
      displayLarge: TextStyle(
        fontSize: 32.sp,
        fontWeight: FontWeight.bold,
        color: textPrimaryColor,
      ),
      displayMedium: TextStyle(
        fontSize: 28.sp,
        fontWeight: FontWeight.bold,
        color: textPrimaryColor,
      ),
      displaySmall: TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeight.bold,
        color: textPrimaryColor,
      ),
      headlineMedium: TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
        color: textPrimaryColor,
      ),
      titleLarge: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
        color: textPrimaryColor,
      ),
      titleMedium: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        color: textPrimaryColor,
      ),
      bodyLarge: TextStyle(
        fontSize: 16.sp,
        color: textPrimaryColor,
      ),
      bodyMedium: TextStyle(
        fontSize: 14.sp,
        color: textSecondaryColor,
      ),
      bodySmall: TextStyle(
        fontSize: 12.sp,
        color: textHintColor,
      ),
    );
  }
  
  // AppBar Theme
  static AppBarTheme get _appBarTheme {
    return AppBarTheme(
      elevation: 0,
      centerTitle: true,
      backgroundColor: Colors.white,
      foregroundColor: textPrimaryColor,
      titleTextStyle: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
        color: textPrimaryColor,
        fontFamily: 'Tajawal',
      ),
    );
  }
  
  // Elevated Button Theme
  static ElevatedButtonThemeData get _elevatedButtonTheme {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        textStyle: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          fontFamily: 'Tajawal',
        ),
      ),
    );
  }
  
  // Outlined Button Theme
  static OutlinedButtonThemeData get _outlinedButtonTheme {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primaryColor,
        side: const BorderSide(color: primaryColor, width: 1.5),
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        textStyle: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          fontFamily: 'Tajawal',
        ),
      ),
    );
  }
  
  // Text Button Theme
  static TextButtonThemeData get _textButtonTheme {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primaryColor,
        textStyle: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          fontFamily: 'Tajawal',
        ),
      ),
    );
  }
  
  // Input Decoration Theme
  static InputDecorationTheme get _inputDecorationTheme {
    return InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey[100],
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: const BorderSide(color: primaryColor, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: const BorderSide(color: errorColor, width: 1.5),
      ),
      hintStyle: TextStyle(
        fontSize: 14.sp,
        color: textHintColor,
        fontFamily: 'Tajawal',
      ),
    );
  }
  
  // Card Theme
  static CardTheme get _cardTheme {
    return CardTheme(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
    );
  }
  
  // Bottom Navigation Bar Theme
  static BottomNavigationBarThemeData get _bottomNavigationBarTheme {
    return BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: primaryColor,
      unselectedItemColor: textHintColor,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
      selectedLabelStyle: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        fontFamily: 'Tajawal',
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: 12.sp,
        fontFamily: 'Tajawal',
      ),
    );
  }
}
