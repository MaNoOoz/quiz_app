import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:quiz_app/app/modules/Control/views/control_view.dart';
import 'package:quiz_app/app/modules/Quiz/models/QuestionModel.dart';
import 'package:quiz_app/app/modules/Quiz/views/QItem.dart';
import 'package:quiz_app/app/modules/utili/Constants.dart';

import '../../../routes/app_pages.dart';
import '../../Widgets/Common/SharedWidgets.dart';
import '../controllers/quiz_controller.dart';

class QuizView extends GetView<QuizController> {
  QuizView({Key? key}) : super(key: key) {
    SchedulerBinding.instance.addPostFrameCallback((d) {
      final game = Get.arguments;
      controller.gameSession = game;
      Logger().d('game ${game.value?.numberOfGames}');
    });
  }

  static const String routeName = Routes.QUIZ;

  @override
  Widget build(BuildContext context) {
    var c = Get.put(QuizController());

    return WillPopScope(
      onWillPop: () async {
        // c.pageController.value.dispose();
        await Get.off(() => const ControlView());
        return false;
        // return Get.delete<QuizController>();
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
                  return controller.loadingStatus.value == LoadingStatus.loading
                      ? Center(child: SharedWidgets().buildLoading())
                      : _buildAnswersView();
                }),

                buildScore(),
                SPACEV10,
                SPACEV10,
                SPACEV10,

                _skipBtn(c),
                // todo remove

                TextButton.icon(
                  onPressed: () {
                    controller.pageController.value.jumpToPage(controller.allQuestions.length);
                  },
                  icon: Icon(
                    Icons.restart_alt,
                    color: Colors.white,
                  ),
                  label: Text(
                    "go to last page",
                    style: mainStyleLBB2,
                  ),
                ),
                //
                // TextButton.icon(
                //   onPressed: () async {
                //     // todo remove
                //     // controller.restScore();
                //     // await controller.saveScoresToLocalStorage();
                //     // var list = await controller.readScoreFromLocal();
                //     // Logger().d('list ${list.length}');
                //   },
                //   icon: Icon(
                //     Icons.restart_alt,
                //     color: Colors.deepOrangeAccent,
                //   ),
                //   label: Text(
                //     "RESET SCORE",
                //     style: mainStyleTW,
                //   ),
                // ),
                //
                // TextButton.icon(
                //   onPressed: () {
                //     controller.pageController.value.jumpToPage(0);
                //   },
                //   icon: Icon(
                //     Icons.restart_alt,
                //     color: Colors.white,
                //   ),
                //   label: Text(
                //     "go to 1 ",
                //     style: mainStyleTW,
                //   ),
                // ),

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
          //   borderRadius: BorderRadius.circular(8),
          //   border: Border.all(color: Colors.black.withOpacity(0.13)),
        ),
        // width: double.infinity,
        // height: 80,
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
                    value: c.seconds / QuizController.maxSeconds,
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

  Widget buildScore() {
    return Obx(() {
      return FadeInUp(
        child: Text(
            controller.isLastPage ? 'Completed' : ' Q ${controller.page.value + 1} / ${controller.allQuestions.length}',
            style: mainStyleLBB),
      );
    });
  }

  Widget _buildAnswersView() {
    var pageView = SizedBox(
      height: 500,
      child: PageView.builder(
        scrollDirection: Axis.horizontal,
        controller: controller.pageController.value,
        pageSnapping: true,

        onPageChanged: (int val) {
          controller.onPageChanged(val);
        },
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.allQuestions.length,

        // shrinkWrap: true,
        itemBuilder: (BuildContext context, int i) {
          QuestionModel questionModel = controller.allQuestions[i];

          return QCard(
            model: questionModel,
            c: controller,
            // press: () => {},
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
                    c.pageController.value.nextPage(duration: Duration(seconds: 1), curve: Curves.easeOut);
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
