import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import '../../modules/utili/Constants.dart';
import '../local/LocalStorage.dart';

class AuthService {
  static LocalStorage storage = LocalStorage();

  Future<bool> isLogged() async {
    var logged = await storage.IsTokenHere();
    if (logged) {
      return true;
    }
    return false;
  }

  Future<bool> ValidToken() async {
    Logger().d("ValidToken Called");

    // var userToken = await getUserToken();
    try {
      var endPoint = "Token";

      var url = "$BASE_URL$endPoint";

      var response = await http.get(Uri.parse(url), headers: headers);

      var data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        Logger().d("getUserApi  json result : $data");

        return true;
      } else {
        Logger().d("getUserApi  json result TOP USERS: $data");
      }
    } on HttpException catch (_, e) {
      Logger().d("$_ $e");

      return false;
    }
    return false;
  }

  Future<String?> getUserToken() async {
    var logged = await storage.readToken(key: TOKEN);
    if (logged != null) {
      return logged;
    }
    return "";
  }
}
