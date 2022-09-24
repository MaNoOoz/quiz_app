import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';
import 'package:quiz_app/app/modules/Login/service/LoginService.dart';

const String TOKEN = 'token';
const String USER_INFO = 'userInfo';
const String USER_SCORES = 'scores';
const String USER_SCORES2 = 'scores2';

class LocalStorage {
  GetStorage storage = GetStorage();

  // save token to local storage
  Future<bool> saveData({required key, required value}) async {
    await storage.write(key, value);

    Logger().d("called : $value");
    return true;
  }

  saveScore({required String storageKey, required List<dynamic> storageValue}) async {
    return await storage.write(storageKey, jsonEncode(storageValue));
  }

  Future<dynamic> readScore({required key}) async {
    var data = await storage.read("$key");
    if (data != null) {
      Logger().d("$data");
      return data;
    }
    return null;
  }

  Future<bool> saveScoreList({required key, required String value}) async {
    List<String> scores = [];
    scores.add(value);

    await storage.write(key, value);

    Logger().d("called : $value");
    return true;
  }

  // check token existence
  Future<bool> IsTokenHere() async {
    var token = await storage.read('token');
    if (token != null) {
      // Logger().d("$token");
      return true;
    }
    return false;
  }

  // read token from local storage
  Future<dynamic> readToken({required key}) async {
    var token = await storage.read("$key");
    if (token != null) {
      Logger().d("$token");
      return token;
    }
    return null;
  }

  Future<LoginResponseModel> readLoginData({required key}) async {
    var token = await storage.read("$key");
    if (token != null) {
      Logger().d("$token");
      // String jsonString = jsonEncode(key);
      var model = LoginResponseModel.fromJson(token);
      Logger().d("model ${model.mobile}");
      return model;
    }
    return LoginResponseModel();
  }
}
