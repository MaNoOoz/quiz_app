import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import '../../modules/utili/Constants.dart';
import '../local/LocalStorage.dart';
import '../provider/ApiProvider.dart';

class AuthService {
  LocalStorage storage = LocalStorage();

  Future<bool> isLogged() async {
    var logged = storage.isTokenHere();
    if (logged) {
      return true;
    }
    return false;
  }

  Future<bool> isValidToken() async {
    Logger().d("ValidToken Called");

    // var userToken = await getUserToken();
    try {
      var endPoint = "Token";

      var url = "$BASE_URL$endPoint";

      var response = await http.get(Uri.parse(url), headers: ApiProvider().buildHeaders());

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

  Future<dynamic> isValidToken2() async {
    try {
      var endPoint = "Token";
      ApiProvider api = ApiProvider();
      var res = await api.get(endPoint);
      Logger().d(res);
      return res;
    } on HttpException catch (_, e) {
      Logger().d("$_ $e");
    }
  }
}
