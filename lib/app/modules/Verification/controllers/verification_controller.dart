import 'dart:async';

import 'package:get/get.dart';
import 'package:quiz_app/app/data/services/AuthService.dart';
import 'package:quiz_app/app/modules/Control/views/control_view.dart';

class VerificationController extends GetxController {
  var code = ''.obs;
  var userName = ''.obs;

  /// check if user token valid on the server
  Future<void> checkToken(VerificationController c) async {
    var res = await AuthService().isValidToken2();
    bool isValid = res['success'];
    if (isValid) {
      await Get.offAll(const ControlView()); // TODO: send arguments ??
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
    // timer?.cancel();
  }
}
