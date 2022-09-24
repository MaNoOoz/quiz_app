import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:quiz_app/app/modules/utili/Constants.dart';

class QuizService {
  Future<List<dynamic>?> getData() async {
    try {
      var endPoint = "Questions";

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
