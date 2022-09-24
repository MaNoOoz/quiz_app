class GameModel {
  int? score;
  String? userName;
  int? numberOfGames;

  GameModel.fromJson(Map<String, dynamic> json) {
    score = json["score"];
    userName = json["userName"];
    numberOfGames = json["numberOfGames"];
  }

  Map<String, dynamic> toJson() => {
        "score": score,
        "userName": userName,
        "numberOfGames": numberOfGames,
      };
}
