import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return MaterialApp(
      title: 'A3Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.montserratTextTheme(theme.textTheme),
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('A3Test')),
        body: const Center(child: Text('A3Test')),
      ),
    );
  }
}
