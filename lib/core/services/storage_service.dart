import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Auth
  static bool get isLogin => _prefs.getBool('islogin') ?? false;
  static Future<void> setLogin(bool value) => _prefs.setBool('islogin', value);
  
  static String? get userName => _prefs.getString('name');
  static Future<void> setUserName(String name) => _prefs.setString('name', name);

  // Settings
  static String get difficulty => _prefs.getString('difficulty') ?? "Medium";
  static Future<void> setDifficulty(String value) => _prefs.setString('difficulty', value);

  static double get roundDuration => _prefs.getDouble('roundDuration') ?? 30;
  static Future<void> setRoundDuration(double value) => _prefs.setDouble('roundDuration', value);

  static double get dotsPerRound => _prefs.getDouble('dotsPerRound') ?? 10;
  static Future<void> setDotsPerRound(double value) => _prefs.setDouble('dotsPerRound', value);

  // Scores
  static List<String> get highestScores => _prefs.getStringList('highestScores') ?? [];
  static Future<void> setHighestScores(List<String> scores) => _prefs.setStringList('highestScores', scores);
}
