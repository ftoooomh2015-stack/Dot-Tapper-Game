import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:math';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int dotspeed = 1000;
  int dotsnum = 10;
  int duration = 30;
  String? yourname;

  double dotX = 0.5;
  double dotY = 0.5;

  Timer? dotTimer;
  int score = 0;
  bool gamestarted = false;

  final Random random = Random();

  final List<Color> dotColors = [
    Colors.redAccent,
    Colors.greenAccent,
    Colors.yellowAccent,
    Colors.purpleAccent,
    Colors.orangeAccent,
    Colors.cyanAccent,
  ];
  Color currentcolor = Colors.redAccent;

  @override
  void initState() {
    super.initState();
    loadGameSettings();
  }

  @override
  void dispose() {
    dotTimer?.cancel();
    super.dispose();
  }

  Future<void> loadGameSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final SharedPreferences login = await SharedPreferences.getInstance();

    String difficulty = prefs.getString('difficulty') ?? "Medium";
    duration = prefs.getDouble('roundDuration')?.toInt() ?? 30;
    dotsnum = prefs.getDouble('dotsPerRound')?.toInt() ?? 10;
    yourname = login.getString('name');

    switch (difficulty) {
      case "Easy":
        dotspeed = 1500;
        break;
      case "Medium":
        dotspeed = 1000;
        break;
      case "Hard":
        dotspeed = 700;
        break;
      case "Insane":
        dotspeed = 400;
        break;
    }
    setState(() {});
  }

  Future<void> saveHighScore(int newScore) async {
    final myscors = await SharedPreferences.getInstance();
    List<String> savedScores = myscors.getStringList('highestScores') ?? [];

    List<int> scores = [];
    for (String s in savedScores) {
      scores.add(int.parse(s));
    }
    scores.add(newScore);

    scores.sort();
    scores = scores.reversed.toList();

    if (scores.length > 10) {
      scores = scores.sublist(0, 10);
    }

    List<String> stringScores = [];
    for (int s in scores) {
      stringScores.add(s.toString());
    }
    myscors.setStringList('highestScores', stringScores);
  }

  startGame() async {
    await loadGameSettings();
    dotTimer?.cancel();
    gamestarted = true;
    score = 0;

    dotTimer = Timer.periodic(Duration(milliseconds: dotspeed), (timer) {
      setState(() {
        dotX = 0.1 + random.nextDouble() * 0.8;
        dotY = 0.1 + random.nextDouble() * 0.8;
        currentcolor = dotColors[random.nextInt(dotColors.length)];
      });
    });

    Future.delayed(Duration(seconds: duration), () {
      dotTimer?.cancel();
      saveHighScore(score);

      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => AlertDialog(
          backgroundColor: Colors.blueGrey[900],
          title: const Text("Game Over", style: TextStyle(color: Colors.white, fontSize: 30, fontFamily: "kotten")),
          content: Text("Your score: $score",
              style: const TextStyle(color: Colors.white)),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                startGame();
              },
              child: const Text("Restart", style: TextStyle(color: Colors.cyan)),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() => gamestarted = false);
              },
              child: const Text("Exit", style: TextStyle(color: Colors.cyan)),
            ),
          ],
        ),
      );
    });
  }

  void dotTapped() {
    setState(() => score++);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.blueGrey[900], // اللون الداكن الدائم
      appBar: AppBar(
        title: Text("Player: $yourname"),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 23,
        ),
        backgroundColor: Colors.blueGrey[800],
        centerTitle: true,
      ),
      body: Stack(
        children: [
          if (gamestarted)
            Positioned(
              left: dotX * MediaQuery.of(context).size.width - 25,
              top: dotY * MediaQuery.of(context).size.height - 100,
              child: GestureDetector(
                onTap: dotTapped,
                child: Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: currentcolor,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),

          if (gamestarted)
            Positioned(
              top: 20,
              left: 20,
              child: Text(
                "Score: $score",
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
            ),

          if (gamestarted)
            Positioned(
              top: 12,
              right: 20,
              child: IconButton(
                onPressed: () {
                  dotTimer?.cancel();
                  setState(() => gamestarted = false);
                },
                iconSize: 32,
                color: Colors.white,
                icon: const Icon(Icons.cancel_outlined),
                tooltip: "Stop Game",
              ),
            ),


          if (!gamestarted)
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50), // نصف القطر للدائرة
                      image: const DecorationImage(
                        image: AssetImage('images/img.jpg'), // مسار الصورة
                        fit: BoxFit.cover,                    // تعبئة الصندوق بدون تشويه
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey[700],
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 19),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    ),
                    onPressed: startGame,
                    child: const Text("Start Game",
                        style: TextStyle(fontSize: 20, color: Colors.white)),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
