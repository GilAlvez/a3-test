import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData appTheme(BuildContext context) {
  final theme = Theme.of(context);

  return ThemeData(
    primarySwatch: Colors.blue,
    textTheme: GoogleFonts.montserratTextTheme(theme.textTheme),
  );
}
