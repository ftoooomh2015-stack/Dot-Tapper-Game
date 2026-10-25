import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tapthedotgame/core/services/storage_service.dart';
import 'package:tapthedotgame/features/auth/login_screen.dart';
import 'package:tapthedotgame/main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double progress = 0.0;

  @override
  void initState() {
    super.initState();

    Timer.periodic(const Duration(milliseconds: 80), (timer) {
      if (!mounted) return;
      setState(() => progress += 0.05);

      if (progress >= 1) {
        timer.cancel();
        bool isLogin = StorageService.isLogin;

        if (isLogin) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const TapTheDot()),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const LoginScreen()),
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 140,
              height: 140,
              child: Image.asset("images/img.jpg"),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: 200,
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.grey[800],
                color: Colors.cyanAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
