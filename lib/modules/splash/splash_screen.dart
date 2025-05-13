import 'package:flutter/material.dart';
import '../../core/routes/app_routes.dart';
import 'widgets/splash_logo.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, AppRoutes.lock);
    });

    return const Scaffold(body: Center(child: SplashLogo()));
  }
}
