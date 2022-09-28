// To parse this JSON data, do
//
//     final scoreModel = scoreModelFromJson(jsonString);

import 'dart:convert';

List<ScoreModel> scoreModelFromJson(String str) =>
    List<ScoreModel>.from(json.decode(str).map((x) => ScoreModel.fromJson(x)));

String scoreModelToJson(List<ScoreModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ScoreModel {
  ScoreModel({
    required this.score,
    required this.dateOfGame,
  });

  String score;
  String dateOfGame;

  factory ScoreModel.fromJson(Map<String, dynamic> json) => ScoreModel(
        score: json["score"],
        dateOfGame: json["dateOfGame"],
      );

  Map<String, dynamic> toJson() => {
        "score": score,
        "dateOfGame": dateOfGame,
      };

  static Map<String, dynamic> toMap(ScoreModel gameModel) {
    return {
      "score": gameModel.score,
      "dateOfGame": gameModel.dateOfGame,
    };
  }

  static String encode(List<ScoreModel> games) => json.encode(
        games.map<Map<String, dynamic>>((game) => ScoreModel.toMap(game)).toList(),
      );

  static List<ScoreModel> decode(String games) =>
      (json.decode(games) as List<dynamic>).map<ScoreModel>((item) => ScoreModel.fromJson(item)).toList();
}
