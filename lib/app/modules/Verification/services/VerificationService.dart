import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import '../../../data/local/LocalStorage.dart';

class VerificationService {
  LocalStorage storage = LocalStorage();

  Future<bool> checkIfTokenValidOnTheServer() async {
    Logger().d("checkUserOnTheServer Called");
    var userToken = await storage.readToken(key: TOKEN);
    Logger().d(": $userToken");

    var BASE_URL = "https://quizu.okoul.com/";
    var headers = {
      'Content-Type': 'application/json',
      "Accept": "application/json",
      "Access-Control_Allow_Origin": "*",
      "Authorization": "Bearer $userToken",
    };
    try {
      var endPoint = "Token";

      var url = "$BASE_URL$endPoint";

      var response = await http.get(Uri.parse(url), headers: headers);

      var data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        Logger().d("$data");
        var isValid = data['succes'];
        Logger().d("isValid : $isValid");

        return true;
      } else {
        Logger().d("$data");
      }
    } on HttpException catch (_, e) {
      Logger().d("$_ $e");

      return false;
    }
    return false;
  }
}
