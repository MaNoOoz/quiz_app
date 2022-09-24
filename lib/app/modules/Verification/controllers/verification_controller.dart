import 'dart:async';

import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:quiz_app/app/modules/Control/views/control_view.dart';
import 'package:quiz_app/app/modules/Login/controllers/login_controller.dart';

import '../../Login/service/LoginService.dart';
import '../../sendName/views/send_name_view.dart';
import '../services/VerificationService.dart';

class VerificationController extends GetxController {
  //TODO: Implement VerificationController
  var code = ''.obs;
  bool isResendAgain = false;
  bool isVerified = false;
  bool isExist = false;
  bool isLoading = false;
  int start = 60;

  // Timer? timer;
  VerificationService verificationService = VerificationService();
  var userName = ''.obs;

  // verify() {
  //   isLoading = true;
  //
  //   const oneSec = Duration(milliseconds: 2000);
  //   timer = Timer.periodic(oneSec, (timer) {
  //     isLoading = false;
  //     isVerified = true;
  //   });
  // }

  /// check if user token valid on the server
  Future<void> checkToken(VerificationController c) async {
    var isValid = await verificationService.checkIfTokenValidOnTheServer();
    if (isValid) {
      LoginService service = LoginService();
      LoginResponseModel user = await service.getLogin(mobile: LoginController().number);
      Logger().d(user.name);

      if (user.name == null) {
        await Get.to(SendNameView());
      } else {
        await Get.offAll(const ControlView());
      }
    }
  }

  @override
  void onInit() {
    super.onInit();
    // t = Get.arguments[0];
    // Logger().d("${t}");
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    // timer?.cancel();
  }
}
