import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import '../../modules/utili/Constants.dart';
import '../provider/ApiProvider.dart';

class ProfileService {
  Future<dynamic> getUserInfo() async {
    try {
      var endPoint = "UserInfo";

      var url = "$BASE_URL$endPoint";
      Logger().d("$url");

      var response = await http.get(Uri.parse("$url"), headers: ApiProvider().buildHeaders());
      final data = jsonDecode(response.body);
      Map<String, dynamic> s = data;

      if (response.statusCode == 200) {
        // Logger().d(data);
        var model = ProfileResponseModel.fromJson(s);
        var name = model.name;
        var mobile = model.mobile;
        Logger().d(name);
        Logger().d(mobile);
        return data;
      } else {
        Logger().d("Error Getting Data");
      }
    } on HttpException catch (_, e) {
      print(e);
    }
  }
}

class ProfileResponseModel {
  String? name;
  String? mobile;

  ProfileResponseModel.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    mobile = json["mobile"];
  }
}
