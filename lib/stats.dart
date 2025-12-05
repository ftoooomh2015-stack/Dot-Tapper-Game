import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Stats extends StatefulWidget {
  const Stats({super.key});

  @override
  State<Stats> createState() => _StatsState();
}

class _StatsState extends State<Stats> {
  List<int> highestScores = [];

    loadmyscores() async {
    final myscors = await SharedPreferences.getInstance();
    List<String> savedScores = myscors.getStringList('highestScores') ?? [];
    setState(() {
      highestScores.clear();
      for (String s in savedScores) {
        highestScores.add(int.parse(s));
      }
    });
  }

  @override
  void initState(){
    super.initState();
    loadmyscores();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        title: Text("My top scores"),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 23,
        ),
        backgroundColor: Colors.blueGrey[800],
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: highestScores.length,
        itemBuilder: (context, index){
          return Card(
            color: Colors.blueGrey[800],
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: index == 0
                  ? Icon(Icons.emoji_events_rounded, color: Colors.amber, size: 30)
                  : null,
              title: Text(
                "Score: ${highestScores[index]}",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: index == 0 ? 24 : 20,
                  fontWeight: index < 3 ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              trailing: index < 3 ? Icon(Icons.star, color: Colors.yellowAccent) : null,
            ),
          );
        },
      ),
    );
  }
}
