import 'package:get/get.dart';

import '../../Quiz/views/quiz_view.dart';

class HomeController extends GetxController {
  startGame() async {
    Get.offNamed(QuizView.routeName);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }
}
