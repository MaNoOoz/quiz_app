import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import '../../utili/Constants.dart';

class LeaderboardService {
  Future<List<dynamic>?> getTopUsers() async {
    try {
      var endPoint = "TopScores";

      var url = "$BASE_URL$endPoint";
      Logger().d("$url");

      var response = await http.get(Uri.parse("$url"), headers: headers);
      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        Logger().d(data);

        return data;
      } else {
        Logger().d("Error Geting Data");
      }
    } on HttpException catch (_, e) {
      print(e);
    }
  }
}
