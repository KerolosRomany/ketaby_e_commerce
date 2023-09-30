import 'package:e_commerce/splash_screen/widgets/splash_screen_body.dart';
import 'package:flutter/material.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: Colors.white,
        body: SplashViewBody()
    );
  }
}