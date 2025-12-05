import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tapthedotgame/login.dart';
import 'main.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  double progress = 0.0;
  void initState() {
    super.initState();

    Timer.periodic(const Duration(milliseconds: 80), (timer) async {
      setState(() => progress += 0.05);
      final SharedPreferences login = await SharedPreferences.getInstance();
      bool islogin = login.getBool("islogin")?? false;

      if (progress >= 1) {
        timer.cancel();
        if(islogin){
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => TapTheDot()),
          );
        }else{
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => Login()),
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
              child: Image.asset("images/img.jpg", ),
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
