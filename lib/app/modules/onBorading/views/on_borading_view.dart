import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/app/modules/Control/views/control_view.dart';

import '../../IntroScreen/controllers/intro_screen_controller.dart';
import '../../Login/views/login_view.dart';
import '../controllers/on_borading_controller.dart';

class OnBoradingView extends GetView<OnBoradingController> {
  const OnBoradingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var c = Get.put(IntroScreenController());
    // return ControlView();
    return Obx(() {
      return c.isLogged.value == false ? const LoginView() : const ControlView(); // TODO: 1
    });
  }
}
