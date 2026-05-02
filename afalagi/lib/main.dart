import 'package:flutter/material.dart';
import 'routes.dart';
import 'core/theme/theme.dart';

void main() {
  runApp(const AfalagiApp());
}

class AfalagiApp extends StatelessWidget {
  const AfalagiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Afalagi Mobile',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: AppRoutes.initial,
      routes: AppRoutes.routes,
    );
  }
}
