import 'package:flutter/material.dart';
import 'package:tapthedotgame/home.dart';
import 'package:tapthedotgame/howtoplay.dart';
import 'package:tapthedotgame/settings.dart';
import 'package:tapthedotgame/splash.dart';
import 'package:tapthedotgame/stats.dart';

class TapTheDot extends StatefulWidget {
  const TapTheDot({super.key});

  @override
  State<TapTheDot> createState() => _TapTheDotState();
}

void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SplashPage(),
    theme: ThemeData(
      useMaterial3: false,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.blueGrey[800],
        selectedItemColor: Colors.cyanAccent,
        unselectedItemColor: Colors.grey[400],
      ),
    ),
  ));
}

class _TapTheDotState extends State<TapTheDot> {
  int myindex = 0;
  final List<Widget> pages = [
    HowToPlay(
      key: const ValueKey('HowToPlay'), // استخدام مفتاح لضمان إعادة البناء
    ),
    Home(
      key: const ValueKey('Home'), // استخدام مفتاح لضمان إعادة البناء
    ),
    Stats(
      key: const ValueKey('Stats'), // استخدام مفتاح لضمان إعادة البناء
    ), // يمكن استخدام const إذا لم تكن لها حالة تتغير
    Settings(
      key: const ValueKey('Settings'), // استخدام مفتاح لضمان إعادة البناء
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[myindex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: myindex,
        onTap: (index) {
          setState(() {
            myindex = index;
          });
        },
        iconSize: 40,
        items: [
          BottomNavigationBarItem(label: '', icon: Icon(Icons.help)),
          BottomNavigationBarItem(label: '', icon: Icon(Icons.sports_esports)),
          BottomNavigationBarItem(label: '', icon: Icon(Icons.bar_chart)),
          BottomNavigationBarItem(label: '', icon: Icon(Icons.extension)),
        ],
      ),
    );
  }
}