import 'package:flutter/material.dart';
import 'package:tapthedotgame/core/services/storage_service.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late String difficulty;
  late double roundDuration;
  late double dotsPerRound;

  final List<String> difficulties = ["Easy", "Medium", "Hard", "Insane"];

  @override
  void initState() {
    super.initState();
    loadSettings();
  }

  void loadSettings() {
    setState(() {
      difficulty = StorageService.difficulty;
      roundDuration = StorageService.roundDuration;
      dotsPerRound = StorageService.dotsPerRound;
    });
  }

  Future<void> saveSettings() async {
    await StorageService.setDifficulty(difficulty);
    await StorageService.setRoundDuration(roundDuration);
    await StorageService.setDotsPerRound(dotsPerRound);
  }

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<String>> difficultyItems = difficulties.map((level) {
      return DropdownMenuItem(
        value: level,
        child: Text(
          level,
          style: const TextStyle(color: Colors.white),
        ),
      );
    }).toList();

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
          onPressed: () async {
            await saveSettings();
            if (!mounted) return;
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
