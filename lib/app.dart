import 'package:flutter/material.dart';
import 'core/routes/app_routes.dart';
import 'core/theme/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Camuflada',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      initialRoute: AppRoutes.splash,
      routes: AppRoutes.routes,
    );
  }
}
