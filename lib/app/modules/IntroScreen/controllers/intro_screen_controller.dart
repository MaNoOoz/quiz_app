import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:quiz_app/app/data/local/LocalStorage.dart';

class IntroScreenController extends GetxController {
  // AuthService _authService = AuthService();
  var isLogged = false.obs;

  Future<void> init() async {
    isLogged.value = LocalStorage().isTokenHere();
    Logger().d("isLogged = ${isLogged.value}");
    await Future.delayed(Duration(seconds: 0));
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
