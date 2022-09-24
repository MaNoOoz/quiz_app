// To parse this JSON data, do
//
//     final questionModel = questionModelFromJson(jsonString);

import 'dart:convert';

QuestionModel questionModelFromJson(String str) => QuestionModel.fromJson(json.decode(str));

String questionModelToJson(QuestionModel data) => json.encode(data.toJson());

class QuestionModel {
  QuestionModel({
    required this.question,
    required this.a,
    required this.b,
    required this.c,
    required this.d,
    required this.correct,
  });

  String question;
  String a;
  String b;
  String c;
  String d;
  String correct;

  factory QuestionModel.fromJson(Map<String, dynamic> json) => QuestionModel(
        question: json["Question"],
        a: json["a"],
        b: json["b"],
        c: json["c"],
        d: json["d"],
        correct: json["correct"],
      );

  Map<String, dynamic> toJson() => {
        "Question": question,
        "a": a,
        "b": b,
        "c": c,
        "d": d,
        "correct": correct,
      };
}
