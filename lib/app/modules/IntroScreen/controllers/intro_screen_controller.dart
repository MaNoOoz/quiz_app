import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../../data/services/AuthService.dart';

class IntroScreenController extends GetxController {
  AuthService _authService = AuthService();
  var isLogged = false.obs;

  Future<void> init() async {
    isLogged.value = await _authService.isLogged();
    Logger().d("isLogged = ${isLogged.value}");
    await Future.delayed(Duration(seconds: 4));
  }

  @override
  void onInit() {
    // init();
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
