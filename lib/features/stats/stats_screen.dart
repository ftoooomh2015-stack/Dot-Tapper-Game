import 'package:flutter/material.dart';
import 'package:tapthedotgame/core/services/storage_service.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  List<int> highestScores = [];

  void loadScores() {
    List<String> savedScores = StorageService.highestScores;
    setState(() {
      highestScores = savedScores.map((s) => int.parse(s)).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    loadScores();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        title: const Text("My top scores"),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 23,
        ),
        backgroundColor: Colors.blueGrey[800],
        centerTitle: true,
      ),
      body: highestScores.isEmpty
          ? const Center(
              child: Text(
                "No scores yet!",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: highestScores.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.blueGrey[800],
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    leading: index == 0
                        ? const Icon(Icons.emoji_events_rounded, color: Colors.amber, size: 30)
                        : CircleAvatar(
                            backgroundColor: Colors.blueGrey[700],
                            child: Text("${index + 1}", style: const TextStyle(color: Colors.white)),
                          ),
                    title: Text(
                      "Score: ${highestScores[index]}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: index == 0 ? 24 : 20,
                        fontWeight: index < 3 ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                    trailing: index < 3 ? const Icon(Icons.star, color: Colors.yellowAccent) : null,
                  ),
                );
              },
            ),
    );
  }
}
