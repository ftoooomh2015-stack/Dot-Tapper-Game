import 'package:flutter/material.dart';

class HowToPlay extends StatelessWidget {
  const HowToPlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        title: const Text("How to play"),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 23,
        ),
        backgroundColor: Colors.blueGrey[800],
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            // مقدمة
            const Text(
              "Welcome to Tap The Dot!",
              style: TextStyle(
                  color: Colors.cyanAccent,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            const Text(
              "Your goal is simple: tap on the red dots as quickly as possible before they disappear. The faster you tap, the higher your score!",
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
            const SizedBox(height: 30),

            // خطوة 1
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Icon(Icons.touch_app, color: Colors.cyanAccent),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "Tap on the colored dots that appear randomly on the screen.",
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),

            // خطوة 2
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Icon(Icons.timer, color: Colors.cyanAccent),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "Each dot stays for a limited time. The faster you tap, the more points you earn.",
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),

            // خطوة 3
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Icon(Icons.star, color: Colors.cyanAccent),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "Try to get the highest score possible before the timer runs out.",
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),

            // نصيحة
            const Text(
                "Tip: Focus on the center and tap quickly! The dots move randomly and get faster with higher difficulty.",
                style: TextStyle(color: Colors.white70, fontSize: 16,height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}
