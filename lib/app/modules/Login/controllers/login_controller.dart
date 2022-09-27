import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:logger/logger.dart';
import 'package:quiz_app/app/modules/Verification/views/verification_view.dart';

import '../../../data/services/LoginService.dart';
import '../../sendName/views/send_name_view.dart';
import '../../utili/Constants.dart';

class LoginController extends GetxController {
  LoginService service = LoginService();
  final loadingStatus = LoadingStatus.completed.obs;

  // PhoneNumber number = PhoneNumber(phoneNumber: "551954619", isoCode: 'SA');
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> formKey2 = GlobalKey<FormState>();
  final TextEditingController mobileController = TextEditingController();

  final number = PhoneNumber(phoneNumber: "551954619", isoCode: 'SA', dialCode: '966').obs;

  // loginUser
  Future<bool> loginUser({required PhoneNumber mobileNumber}) async {
    loadingStatus.value = LoadingStatus.loading;
    var res = await service.getLogin(mobile: mobileNumber);

    // var model = LoginResponseModel.fromJson(res);
    var userName = res["name"];
    // var mobileNum = res["mobile"];
    // Map <String, dynamic> data ={
    //   "userName":"$userName",
    //   "mobileNum":"$mobileNum",
    // };

    if (userName != null) {
      if (userName == null) {
        Logger().d("userName --- ${userName}");
        Get.toNamed(SendNameView.routeName);
      } else {
        Get.toNamed(VerificationView.routeName);
      }
      loadingStatus.value = LoadingStatus.completed;
      return true;
    }
    return false;
    // await Future.delayed(const Duration(seconds: 2), () {
    //   Logger().d("loginUser --- ${loadingStatus.value}");
    // });

    // if (user.name == null) {
    //   Get.to(SendNameView());
    // } else {}

    // Get.toNamed(VerificationView.routeName, arguments: [mobileNumber, user]);
    // Get.toNamed(VerificationView.routeName, arguments: [mobileNumber, user]);

    loadingStatus.value = LoadingStatus.completed;
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
    mobileController.dispose();
  }
}
