import 'dart:convert';

import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../local/LocalStorage.dart';
import '../provider/ApiProvider.dart';

class LoginService {
  Future<dynamic> getLogin({required PhoneNumber mobile}) async {
    ApiProvider api = ApiProvider();
    var endPoint = "Login";
    var body = jsonEncode({
      'OTP': '0000',
      'mobile': '${mobile.phoneNumber}',
    });

    var res = await api.post(endPoint, body: body);

    // save it to local
    LocalStorage().saveData(key: TOKEN, value: res['token']);

    //;
    return res;
  }
}
