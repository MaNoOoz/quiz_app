import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import '../../utili/Constants.dart';

class SendNameController extends GetxController {
  //TODO: Implement SendNameController

  final count = 0.obs;

  final TextEditingController nameController = TextEditingController();
  String _userName = "";
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  get userName => _userName;

  set userName(value) {
    _userName = value;
  }

  var isLoading = false;

  Future<void> addNewUser({required String userName}) async {
    var endpoint = "Name";
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
    var body = jsonEncode({'name': '${userName}'});
    Logger().d("body : $userName");

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
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
