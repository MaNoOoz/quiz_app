import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:quiz_app/app/modules/Login/service/LoginService.dart';
import 'package:quiz_app/app/modules/Verification/views/verification_view.dart';

class LoginController extends GetxController {
  LoginService service = LoginService();

  // PhoneNumber number = PhoneNumber(phoneNumber: "551954619", isoCode: 'SA');
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> formKey2 = GlobalKey<FormState>();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  PhoneNumber number = PhoneNumber(phoneNumber: "551954619", isoCode: 'SA', dialCode: '966');

  var isLoading = false;

  // loginUser
  Future<void> loginUser({required PhoneNumber mobileNumber}) async {
    // LoginResponseModel user = await service.getLogin(mobile: mobileNumber);

    Get.toNamed(VerificationView.routeName);

    // if (user.name == null) {
    //   Get.to(SendNameView());
    // } else {}

    // Get.toNamed(VerificationView.routeName, arguments: [mobileNumber, user]);
    // Get.toNamed(VerificationView.routeName, arguments: [mobileNumber, user]);
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
