import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/app/modules/Control/views/control_view.dart';
import 'package:share_plus/share_plus.dart';

import '../../../routes/app_pages.dart';
import '../../Widgets/Common/SharedWidgets.dart';
import '../../utili/Constants.dart';
import '../controllers/result_controller.dart';

class ResultView extends GetView<ResultController> {
  const ResultView({Key? key}) : super(key: key);
  static const String routeName = Routes.RESULT;

  @override
  Widget build(BuildContext context) {
    var answers = Get.arguments;
    // var answers = "10";
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(30),
          child: Center(
            child: Column(
              children: [
                SharedWidgets().buildCustomAppbar(onPressed: () => {Get.offAllNamed(ControlView.routeName)}),
                SPACEV10,
                SPACEV10,
                SPACEV10,
                SharedWidgets().buildLogo(),
                SharedWidgets().buildDesc("Congrats You Have Completed $answers "
                    "\n correct answers"),
                SharedWidgets().buildShareBtn("Share Your Score", mainStyleLW, onPressed: () async {
                  Share.share('I answered $answers correct answers in QuizU!');
                  // c.nextQuestion();
                  // c.firstPressSkip.value = true;
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
