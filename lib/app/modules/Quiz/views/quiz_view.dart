import 'package:flutter/material.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:quiz_app/app/data/models/QuestionModel.dart';
import 'package:quiz_app/app/modules/Quiz/views/QItem.dart';
import 'package:quiz_app/app/modules/utili/Constants.dart';

import '../../../routes/app_pages.dart';
import '../../Widgets/Common/SharedWidgets.dart';
import '../controllers/quiz_controller.dart';

class QuizView extends GetView<QuizController> {
  const QuizView({Key? key}) : super(key: key);

  static const String routeName = Routes.QUIZ;

  @override
  Widget build(BuildContext context) {
    var c = Get.put(QuizController());

    return WillPopScope(
      onWillPop: () async {
        // await Get.off(() => const ControlView());
        c.pageController.value.jumpToPage(c.allQuestions.length);
        Get.back();
        return false;
      },
      child: SafeArea(
        child: Scaffold(
            body: Container(
          padding: const EdgeInsetsDirectional.all(10),
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topRight,
              colors: GradientColors.cloudyKnoxville,
              // stops: [0.6, 0.7],
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildTimer(c),
                Obx(() {
                  return _buildAnswersView();
                }),
                SPACEV10,
                SPACEV10,
                _skipBtn(c),
                SPACEV10,
              ],
            ),
          ),
        )),
      ),
    );
  }

  Widget _buildTimer(QuizController c) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.black.withOpacity(0.13)),
        ),
        width: double.infinity,
        height: 80,
        child: Obx(() {
          var timer = SizedBox(
            width: Get.width,
            height: 48,
            child: Stack(
              alignment: Alignment.center,
              // fit: StackFit.expand,
              children: [
                Padding(
                  padding: const EdgeInsets.all(1),
                  child: CircularProgressIndicator(
                    strokeWidth: 5,
                    valueColor:
                        AlwaysStoppedAnimation(c.seconds.value == 120 ? Colors.green.shade300 : Colors.red.shade300),
                    value: c.seconds.value / QuizController.maxSeconds,
                  ),
                ),
                Center(
                  child: Text(
                    c.seconds.toString(),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.15,
                      color: c.isCompleted() ? Colors.green.shade300 : Colors.red.shade300,
                    ),
                  ),
                ),
              ],
            ),
          ).obs;

          return timer.value;
        }));
  }

  Widget _buildAnswersView() {
    var pageView = SizedBox(
      height: 500,
      child: PageView.builder(
        scrollDirection: Axis.horizontal,
        controller: controller.pageController.value,
        pageSnapping: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.allQuestions.length,
        itemBuilder: (BuildContext context, int i) {
          QuestionModel questionModel = controller.allQuestions[i];

          return QCard(
            model: questionModel,
            c: controller,
          );
        },
      ),
    ).obs;
    return pageView.value;
  }

  Widget _skipBtn(QuizController c) {
    return Obx(() {
      return Visibility(
          visible: c.firstPressSkip.value,
          child: SharedWidgets().buildRequestBtn(
            "تخطي",
            mainStyleTWM,
            onPressed: c.firstPressSkip.value
                ? () {
                    c.firstPressSkip.value = false;
                    c.nextQuestion();
                    Logger().e("${c.firstPressSkip.value}");
                  }
                : null,
          ));
    });
    // if (c.firstPressSkip.value == false) {
    //   return SharedWidgets().buildRequestBtn("Skip", mainStyleLW, onPressed: () {
    //     c.skipQustion().whenComplete(() => c.firstPressSkip.value = true);
    //   });
    // } else {
    //   return Container();
    // }
  }
}
