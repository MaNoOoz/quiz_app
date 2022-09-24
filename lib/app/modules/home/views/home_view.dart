import 'package:flutter/material.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
import 'package:get/get.dart';
import 'package:quiz_app/app/modules/utili/Constants.dart';

import '../../Quiz/views/quiz_view.dart';
import '../../Widgets/Common/SharedWidgets.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  static const String routeName = '/home';

  @override
  Widget build(BuildContext context) {
    var name = Get.arguments;

    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topRight,
              colors: GradientColors.white,
              // stops: [0.6, 0.7],
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SPACEV10,
                    SPACEV10,
                    SPACEV10,
                    SPACEV10,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SharedWidgets().buildTextLeft("$name", mainStyleTB),
                        SPACEH50,
                        SharedWidgets().buildTextRight(" مرحباً 👋 ", mainStyleTB),
                      ],
                    ),
                    SPACEV10,
                    SPACEV10,
                    SPACEV10,
                    SPACEV10,
                    SPACEV10,
                    SPACEV10,
                    SPACEV10,
                    SPACEV10,
                    SharedWidgets().buildTextRight("Ready to Test You knowledge and challenge Others", mainStyleTMBL),
                    SPACEV10,
                    SPACEV10,
                    SharedWidgets()
                        .buildRequestBtn("Quiz Me ! 🤞", mainStyleTM, onPressed: () => Get.to(() => const QuizView())),
                    SPACEV10,
                    SPACEV10,
                    SPACEV10,
                    SPACEV10,
                    SPACEV10,
                    SharedWidgets().buildTextTop("Answer as much questions as u can in 2 minutes", mainStyleTMBL),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
