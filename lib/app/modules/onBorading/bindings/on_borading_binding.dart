import 'package:get/get.dart';

import '../controllers/on_borading_controller.dart';

class OnBoradingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnBoradingController>(
      () => OnBoradingController(),
    );
  }
}
