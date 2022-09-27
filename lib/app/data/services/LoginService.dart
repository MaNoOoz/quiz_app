import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:logger/logger.dart';

import '../../modules/utili/Constants.dart';
import '../local/LocalStorage.dart';

class LoginService {
  Future<dynamic> getLogin({required PhoneNumber mobile}) async {
    var headerToken = LocalStorage().read(key: TOKEN);
    Logger().d(": $headerToken");

    try {
      var endPoint = "Login";

      var mainToken =
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NSwiaWF0IjoxNjYzMzU4NDY1fQ.LlVAcArd2Bn3gtdanoHlfMOsHn0gRMqvVHozUk4bjWM";

      var headers = {
        'Content-Type': 'application/json',
        "Accept": "application/json",
        "Access-Control_Allow_Origin": "*",
        "Authorization": "Bearer $mainToken",
      };

      var url = "$BASE_URL$endPoint";
      Logger().d(url);

      var body = jsonEncode({
        'OTP': '0000',
        'mobile': '${mobile.phoneNumber}',
      });

      Logger().d("mobile : $mobile");

      var response = await http
          .post(
        Uri.parse(url),
        headers: headers,
        body: body,
      )
          .timeout(const Duration(seconds: 5), onTimeout: () {
        return http.Response('Error', 408); // Request Timeout response status code
        // showSnackBarRed();
      });

      // Logger().d(response.body);

      final data = jsonDecode(response.body);
      // Logger().d(data);

      if (response.statusCode == 201) {
        var token = data['token'];
        // changeMainToken to the new one
        // var token = model.token;
        if (token != null) {
          mainToken = token;
        } else {
          mainToken = "your token is null";
        }
        Logger().d(token);

        // save it to local storage
        LocalStorage().saveData(key: TOKEN, value: mainToken);
        LocalStorage().saveData(key: USER_INFO, value: data);

        return data;
      }
    } catch (e) {
      print(e);
    }
  }
}
