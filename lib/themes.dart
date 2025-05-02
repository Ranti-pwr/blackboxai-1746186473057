import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum ThemeType { minimalist, dark, colorful }

class Themes {
  static final ThemeData minimalistTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
    useMaterial3: true,
    textTheme: GoogleFonts.openSansTextTheme(),
    brightness: Brightness.light,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black87,
      elevation: 0,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.deepPurple,
      brightness: Brightness.dark,
    ),
    useMaterial3: true,
    textTheme: GoogleFonts.openSansTextTheme(
      ThemeData(brightness: Brightness.dark).textTheme,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black87,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
  );

  static final ThemeData colorfulTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
    useMaterial3: true,
    textTheme: GoogleFonts.poppinsTextTheme(),
    brightness: Brightness.light,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.teal,
      foregroundColor: Colors.white,
      elevation: 4,
    ),
  );
}
