import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';

import '../models/LoginResponseModel.dart';
import '../models/ProfileResponseModel.dart';

const String TOKEN = 'token';
const String USER_INFO = 'userInfo';
const String USER_GAMES = 'userGames';
const String SCORES = 'scores';

class LocalStorage {
  final _storage = GetStorage();

  remove({required key}) async {
    await _storage.remove(key);
    Logger().d("called : $key");
  }

  void writeIfNull(String key, dynamic value) {
    _storage.writeIfNull(key, value);
  }

  saveReadScore() {
    final _downloads = ReadWriteValue(SCORES, List<Map<String, String>>.empty(growable: true), () => _storage);
    return _downloads;
  }

  // save token to local storage
  saveData({required key, required value}) async {
    await _storage.write(key, value);
    Logger().d("data saved with value  : $value");
    return true;
  }

  // check token existence
  bool isTokenHere() {
    var token = _storage.read(TOKEN);
    if (token != null) {
      Logger().d("$token");
      return true;
    }
    return false;
  }

  // read token from local storage
  read({required key}) {
    var data = _storage.read("$key");
    if (data != null) {
      // Logger().d("$data");
      return data;
    }
    // Logger().d("$data");

    return null;
  }

  LoginResponseModel ModelFromLoginData({required key}) {
    LoginResponseModel model =
        LoginResponseModel(name: "test User", mobile: "05555555", success: false, token: "", msg: "hi");
    var data = _storage.read("$key");
    if (data != null) {
      Logger().d("$data");
      // String jsonString = jsonEncode(key);
      model = LoginResponseModel.fromJson(data);
      Logger().d("model ${model.mobile}");
    }

    return model;
  }

  ProfileResponseModel ModelFromProfileResponseModel({required key}) {
    var model;
    var data = _storage.read("$key");
    if (data != null) {
      Logger().d("$data");
      // String jsonString = jsonEncode(key);
      model = ProfileResponseModel.fromJson(data);
      Logger().d("model ${model.mobile}");
    }

    return model;
  }
}
