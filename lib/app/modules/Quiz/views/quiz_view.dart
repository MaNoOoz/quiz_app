import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:quiz_app/app/modules/Quiz/models/QuestionModel.dart';
import 'package:quiz_app/app/modules/Quiz/views/QItem.dart';
import 'package:quiz_app/app/modules/utili/Constants.dart';

import '../../Widgets/Common/SharedWidgets.dart';
import '../../Widgets/Common/countdown_timer.dart';
import '../controllers/quiz_controller.dart';

class QuizView extends GetView<QuizController> {
  const QuizView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var c = Get.put(QuizController());

    return SafeArea(
      child: Scaffold(
          body: Container(
        padding: const EdgeInsetsDirectional.all(10),
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topRight,
            colors: GradientColors.harmonicEnergy,
            // stops: [0.6, 0.7],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.deepOrangeAccent.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.black.withOpacity(0.13)),
                ),
                width: double.infinity,
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Obx(() {
                      return CountdownTimer(
                        time: '${c.time}',
                      );
                    })
                  ],
                ),
              ),
              // TextButton(
              //   onPressed: () {
              //     c.startQuiz();
              //   },
              //   child: Text(
              //     "start",
              //     style: mainStyleTW,
              //   ),
              // ),
              // TextButton(
              //   onPressed: () {
              //     c.pauseTimer();
              //   },
              //   child: Text(
              //     "pause",
              //     style: mainStyleTW,
              //   ),
              // ),

              SizedBox(
                height: 500,
                // width: 200,
                child: Obx(() {
                  return _buildAnswersView();
                }),
              ),

              buildObx(),

              // _skipBtn(c),
              // todo remove
              TextButton.icon(
                onPressed: () {
                  controller.pageController.value.jumpToPage(controller.listOfQuestions.length);
                },
                icon: Icon(
                  Icons.restart_alt,
                  color: Colors.white,
                ),
                label: Text(
                  "go to last page",
                  style: mainStyleTW,
                ),
              ),

              TextButton.icon(
                onPressed: () async {
                  // controller.restScore();
                  await controller.saveScoresToLocalStorage();
                  var list = await controller.readScoreFromLocal();
                  Logger().d('list ${list.length}');
                },
                icon: Icon(
                  Icons.restart_alt,
                  color: Colors.deepOrangeAccent,
                ),
                label: Text(
                  "RESET SCORE",
                  style: mainStyleTW,
                ),
              ),

              TextButton.icon(
                onPressed: () {
                  controller.pageController.value.jumpToPage(0);
                },
                icon: Icon(
                  Icons.restart_alt,
                  color: Colors.white,
                ),
                label: Text(
                  "go to 1 ",
                  style: mainStyleTW,
                ),
              ),

              SPACEV10,
            ],
          ),
        ),
      )),
    );
  }

  Widget buildObx() {
    return Obx(() {
      return FadeInUp(
        child: Text(
            controller.isLastPage ? 'Completed' : '${controller.page.value + 1} / ${controller.listOfQuestions.length}',
            style: mainStyleTW),
      );
    });
  }

  Widget _buildAnswersView() {
    var pageView = PageView.builder(
      scrollDirection: Axis.horizontal,
      controller: controller.pageController.value,

      onPageChanged: (val) {
        controller.page.value = val;
        controller.questionIndex.value = val;
        if (val + 1 == controller.listOfQuestions.length) {}
        Logger().e(controller.page.toString());
        Logger().e(controller.questionIndex.toString());
        Logger().e(controller.isFirstPage.toString());
        Logger().e(controller.totalScore.toString());
      },
      physics: const NeverScrollableScrollPhysics(),
      itemCount: controller.listOfQuestions.length,

      // shrinkWrap: true,
      itemBuilder: (BuildContext context, int i) {
        QuestionModel questionModel = controller.listOfQuestions[i];

        return QCard(
          model: questionModel,
          c: controller,
          // press: () => {},
        );
      },
    ).obs;
    return pageView.value;
  }

  Widget _skipBtn(QuizController c) {
    return Obx(() {
      return Visibility(
        // TODO: this is not WORKING
        visible: c.firstPressSkip.value,
        child: SharedWidgets().buildRequestBtn("Skip", mainStyleLW, onPressed: () async {
          c.nextQuestion();
          c.firstPressSkip.value = true;
        }),
      );
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
