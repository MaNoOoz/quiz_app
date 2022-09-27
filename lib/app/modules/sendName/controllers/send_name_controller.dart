import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:quiz_app/app/data/local/LocalStorage.dart';

import '../../../data/provider/ApiProvider.dart';

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

  Future<dynamic> updateUserName({required String userName}) async {
    var headerToken = LocalStorage().read(key: TOKEN);
    Logger().d("headerToken : $headerToken");

    ApiProvider api = ApiProvider();
    var endPoint = "Name";
    var body = jsonEncode({
      'OTP': '0000',
      'name': '${userName}',
    });

    var res = await api.post(endPoint, body: body);

    // save it to local
    // LocalStorage().saveData(key: TOKEN, value: res['token']);

    //;
    return res;
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
