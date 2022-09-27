import 'dart:convert';

class GameModel {
  int? id;
  int? score;
  String? userName;
  int? numberOfGames;

  GameModel(this.id, {required this.score, required this.userName, required this.numberOfGames});

  GameModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    score = json["score"];
    userName = json["userName"];
    numberOfGames = json["numberOfGames"];
  }

  Map<String, dynamic> toJson() => {
        "score": score,
        "userName": userName,
        "numberOfGames": numberOfGames,
      };

  static Map<String, dynamic> toMap(GameModel gameModel) => {
        "score": gameModel.score,
        "userName": gameModel.userName,
        "numberOfGames": gameModel.numberOfGames,
      };

  static String encode(List<GameModel> games) => json.encode(
        games.map<Map<String, dynamic>>((game) => GameModel.toMap(game)).toList(),
      );

  static List<GameModel> decode(String games) =>
      (json.decode(games) as List<dynamic>).map<GameModel>((item) => GameModel.fromJson(item)).toList();
}
