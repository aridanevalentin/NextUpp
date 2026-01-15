import 'package:flutter/material.dart';

class AppTheme {
  // Gunmetal Dark Palette
  static const Color background = Color(0xFF14181C); // Fondo oscuro profundo
  static const Color surface = Color(0xFF2C3440); // Tarjetas/Paneles
  static const Color primary = Colors.white; // Texto principal / Acentuado
  static const Color secondary = Color(
    0xFF99AABB,
  ); // Texto secundario / Iconos inactivos
  static const Color accent = Color(
    0xFF00E054,
  ); // Verde "Letterboxd" para acciones positivas

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: background,
      colorScheme: const ColorScheme.dark(
        primary: primary,
        secondary: secondary,
        surface: surface,
        surfaceContainerHighest: surface, // Material 3 Cards
        onSurface: primary,
        error: Color(0xFFFF6B6B),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent, // Para el glassmorphism
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: primary,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
        iconTheme: IconThemeData(color: primary),
      ),
      /*
      cardTheme: CardTheme(
        color: surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Bordes más suaves
          side: BorderSide(
            color: Colors.white.withValues(alpha: 0.05),
            width: 1,
          ), // Borde sutil
        ),
        margin: const EdgeInsets.all(0),
      ),
      */
      textTheme: const TextTheme(
        titleLarge: TextStyle(color: primary, fontWeight: FontWeight.bold),
        titleMedium: TextStyle(color: primary, fontWeight: FontWeight.w600),
        bodyMedium: TextStyle(color: secondary, fontSize: 14),
        bodySmall: TextStyle(color: secondary, fontSize: 12),
      ),
      iconTheme: const IconThemeData(color: secondary),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(0xB314181C), // Semi-transparente
        selectedItemColor: primary,
        unselectedItemColor: secondary,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
      ),
      // Slider y otros componentes
      sliderTheme: SliderThemeData(
        activeTrackColor: primary,
        inactiveTrackColor: surface,
        thumbColor: primary,
        overlayColor: primary.withValues(alpha: 0.2),
      ),
    );
  }
}
