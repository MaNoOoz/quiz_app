import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';

import '../models/LoginResponseModel.dart';

const String TOKEN = 'token';
const String USER_INFO = 'userInfo';
const String USER_GAMES = 'userGames';

class LocalStorage {
  GetStorage storage = GetStorage();

  remove({required key}) async {
    if (isTokenHere() == true) {
      await storage.remove(key);
    }
    Logger().d("called : $key");
  }

  // save token to local storage
  saveData({required key, required value}) async {
    await storage.write(key, value);
    Logger().d("data saved with value  : $value");
    return true;
  }

  // check token existence
  bool isTokenHere() {
    var token = storage.read(TOKEN);
    if (token != null) {
      Logger().d("$token");
      return true;
    }
    return false;
  }

  // read token from local storage
  read({required key}) {
    var data = storage.read("$key");
    if (data != null) {
      Logger().d("$data");
      return data;
    }
    Logger().d("$data");

    return null;
  }

  LoginResponseModel ModelFromLoginData({required key}) {
    LoginResponseModel model =
        LoginResponseModel(name: "test User", mobile: "05555555", success: false, token: "", msg: "hi");
    var data = storage.read("$key");
    if (data != null) {
      Logger().d("$data");
      // String jsonString = jsonEncode(key);
      model = LoginResponseModel.fromJson(data);
      Logger().d("model ${model.mobile}");
    }

    return model;
  }
}
