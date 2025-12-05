import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tapthedotgame/home.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String difficulty = "Medium";
  double roundDuration = 30;
  double dotsPerRound = 10;

  final List<String> difficulties = ["Easy", "Medium", "Hard", "Insane"];

  @override
  void initState() {
    super.initState();
    loadSettings();
  }

  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      difficulty = prefs.getString('difficulty') ?? "Medium";
      roundDuration = prefs.getDouble('roundDuration') ?? 30;
      dotsPerRound = prefs.getDouble('dotsPerRound') ?? 10;
    });
  }

  Future<void> saveSettings() async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setString('difficulty', difficulty);
    prefs.setDouble('roundDuration', roundDuration);
    prefs.setDouble('dotsPerRound', dotsPerRound);
  }

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<String>> difficultyItems = [];
    for (String level in difficulties) {
      difficultyItems.add(
        DropdownMenuItem(
          value: level,
          child: Text(
            level,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        title: const Text("Settings"),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 23,
        ),
        backgroundColor: Colors.blueGrey[800],
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            saveSettings();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.white,
                content: Text(
                  "Settings saved",
                  style: TextStyle(color: Colors.blueGrey[800]),
                ),
              ),
            );
          },
          icon: const Icon(Icons.checklist_rtl_outlined),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            "Difficulty Level",
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
          const SizedBox(height: 8),
          DropdownButton<String>(
            dropdownColor: Colors.blueGrey[800],
            value: difficulty,
            style: const TextStyle(color: Colors.white, fontSize: 16),
            items: difficultyItems,
            onChanged: (value) {
              setState(() => difficulty = value!);
            },
          ),
          const SizedBox(height: 20),
          Text(
            "Round Duration: ${roundDuration.toInt()} sec",
            style: const TextStyle(fontSize: 18, color: Colors.white),
          ),
          Slider(
            min: 10,
            max: 120,
            value: roundDuration,
            activeColor: Colors.cyanAccent,
            inactiveColor: Colors.grey[700],
            onChanged: (v) {
              setState(() => roundDuration = v);
            },
          ),
          const SizedBox(height: 20),
          Text(
            "Dots per round: ${dotsPerRound.toInt()}",
            style: const TextStyle(fontSize: 18, color: Colors.white),
          ),
          Slider(
            min: 5,
            max: 50,
            value: dotsPerRound,
            activeColor: Colors.cyanAccent,
            inactiveColor: Colors.grey[700],
            onChanged: (v) {
              setState(() => dotsPerRound = v);
            },
          )
        ],
      ),
    );
  }
}
