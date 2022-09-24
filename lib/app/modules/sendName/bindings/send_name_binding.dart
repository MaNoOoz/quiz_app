import 'package:get/get.dart';

import '../controllers/send_name_controller.dart';

class SendNameBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SendNameController>(
      () => SendNameController(),
    );
  }
}
