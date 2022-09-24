import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:logger/logger.dart';

import '../../../data/local/LocalStorage.dart';
import '../../utili/Constants.dart';

class LoginService {
  LocalStorage storage = LocalStorage();
  var myMobilePhoneToken = "";

  Future<LoginResponseModel> getLogin({required PhoneNumber mobile}) async {
    var endpoint = "Login";
    // var BASE_URL = "https://quizu.okoul.com/";
    var mainToken =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NSwiaWF0IjoxNjYzMzU4NDY1fQ.LlVAcArd2Bn3gtdanoHlfMOsHn0gRMqvVHozUk4bjWM";

    var headers = {
      'Content-Type': 'application/json',
      "Accept": "application/json",
      "Access-Control_Allow_Origin": "*",
      "Authorization": "Bearer $mainToken",
    };

    var url = "$BASE_URL$endpoint";
    Logger().d(url);
    var body = jsonEncode({
      'OTP': '0000',
      'mobile': '${mobile.phoneNumber}',
    });
    Logger().d("mobile : $mobile");

    var response = await http.post(
      Uri.parse("$url"),
      headers: headers,
      body: body,
    );
    // Logger().d(response.body);

    final data = jsonDecode(response.body);
    // Logger().d(data);

    if (response.statusCode == 201) {
      // Logger().d(response.body);
      // Logger().d(jsonEncode(response.body));
      Map<String, dynamic> s = data;
      Logger().d(s);

      var model = LoginResponseModel.fromJson(data);
      var token = model.token;
      Logger().d(token);

      // save it to local storage
      storage.saveData(key: TOKEN, value: token);
      storage.saveData(key: USER_INFO, value: data);

      // read it
      storage.readLoginData(key: USER_INFO);

      Logger().d(USER_INFO);

      return LoginResponseModel.fromJson(data);
    }
    return LoginResponseModel();
  }
}

class LoginResponseModel {
  String? name;
  String? mobile;
  String? token;
  String? msg;
  bool? success;

  LoginResponseModel();

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    mobile = json["mobile"];
    token = json["token"];
    msg = json["msg"];
    success = json["success"];
  }
  Map<String, dynamic> toJson() => {
        "success": success,
        "msg": msg,
        "token": token,
        "name": name,
        "mobile": mobile,
      };
}
