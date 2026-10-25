import 'package:flutter/material.dart';
import 'package:tapthedotgame/core/services/storage_service.dart';
import 'package:tapthedotgame/main.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController con = TextEditingController();

  @override
  void dispose() {
    con.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[800],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome!',
              style: TextStyle(
                fontSize: 50,
                fontFamily: "kotten",
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 370,
              child: TextField(
                controller: con,
                style: const TextStyle(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  labelText: 'Your name',
                  labelStyle: const TextStyle(
                    color: Colors.white,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: const BorderSide(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 33),
            ElevatedButton(
              onPressed: () async {
                if (con.text.isNotEmpty) {
                  await StorageService.setUserName(con.text);
                  await StorageService.setLogin(true);
                  if (!mounted) return;
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const TapTheDot()),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                fixedSize: const Size(250, 60),
                backgroundColor: Colors.cyanAccent,
              ),
              child: const Text(
                "Let's go!",
                style: TextStyle(color: Colors.black87),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
