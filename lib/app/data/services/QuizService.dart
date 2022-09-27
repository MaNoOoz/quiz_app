import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:quiz_app/app/modules/utili/Constants.dart';

import '../provider/ApiProvider.dart';

class QuizService {
  Future<List<dynamic>?> getData() async {
    try {
      var endPoint = "Questions";

      var url = "$BASE_URL$endPoint";
      Logger().d("$url");

      var response = await http.get(Uri.parse("$url"), headers: ApiProvider().buildHeaders());
      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        // Logger().d(data);
        return data;
      } else {
        Logger().d("Error Geting Data");
      }
    } on HttpException catch (_, e) {
      print(e);
    }
  }

  Future<List<dynamic>?> getData2() async {
    var endPoint = "Questions";
    ApiProvider api = ApiProvider();
    var res = await api.get(endPoint);
    Logger().d(res);
    return res;
  }
}
