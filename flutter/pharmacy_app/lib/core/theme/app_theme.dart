import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.amber[50],
        shadowColor: Colors.yellow[100],
      ),
      colorScheme: ColorScheme.light().copyWith(
        surface: Colors.blueGrey.shade50,
        errorContainer: Colors.red.shade50,
        onErrorContainer: Colors.red.shade200,
      ),
      textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.black)),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color.fromARGB(255, 66, 66, 66),
      appBarTheme: AppBarTheme(
        backgroundColor: const Color.fromARGB(255, 44, 44, 44),
        shadowColor: Colors.grey,
      ),
      colorScheme: ColorScheme.dark().copyWith(
        surface: Colors.grey.shade900,
        errorContainer: const Color.fromARGB(255, 56, 34, 37),
        onErrorContainer: const Color.fromARGB(255, 236, 180, 180),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.selected)) {
            return const Color.fromARGB(255, 16, 1, 1);
          }
          return Colors.grey.shade400;
        }),
        trackColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.selected)) {
          return Colors.deepPurple.shade400; // Açıkken arkadaki tünel rengi
        }
        return Colors.grey.shade800; 
      }),
      ),

      textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.white)),
    );
  }
}
