import 'package:flutter/material.dart';
import 'package:tapthedotgame/core/services/storage_service.dart';
import 'package:tapthedotgame/features/auth/splash_screen.dart';
import 'package:tapthedotgame/features/game/game_screen.dart';
import 'package:tapthedotgame/features/how_to_play/how_to_play_screen.dart';
import 'package:tapthedotgame/features/settings/settings_screen.dart';
import 'package:tapthedotgame/features/stats/stats_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tap The Dot',
      theme: ThemeData(
        useMaterial3: false,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.blueGrey[800],
          selectedItemColor: Colors.cyanAccent,
          unselectedItemColor: Colors.grey[400],
        ),
      ),
      home: const SplashScreen(),
    );
  }
}

class TapTheDot extends StatefulWidget {
  const TapTheDot({super.key});

  @override
  State<TapTheDot> createState() => _TapTheDotState();
}

class _TapTheDotState extends State<TapTheDot> {
  int myIndex = 1; // جعل صفحة اللعب هي الافتراضية عند الدخول

  final List<Widget> pages = [
    const HowToPlayScreen(key: ValueKey('HowToPlay')),
    const GameScreen(key: ValueKey('Game')),
    const StatsScreen(key: ValueKey('Stats')),
    const SettingsScreen(key: ValueKey('Settings')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: myIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: myIndex,
        onTap: (index) {
          setState(() {
            myIndex = index;
          });
        },
        iconSize: 30,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(label: 'Help', icon: Icon(Icons.help_outline)),
          BottomNavigationBarItem(label: 'Play', icon: Icon(Icons.sports_esports)),
          BottomNavigationBarItem(label: 'Stats', icon: Icon(Icons.bar_chart)),
          BottomNavigationBarItem(label: 'Settings', icon: Icon(Icons.settings)),
        ],
      ),
    );
  }
}
