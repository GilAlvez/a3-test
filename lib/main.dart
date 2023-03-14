import 'package:flutter/material.dart';

import 'package:a3_test/core/routes.dart';
import 'package:a3_test/core/theme.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'A3Test',
      theme: appTheme(context),
      routerConfig: routes,
    );
  }
}
