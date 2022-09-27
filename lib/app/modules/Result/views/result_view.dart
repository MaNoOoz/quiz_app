import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:share_plus/share_plus.dart';

import '../../../data/app_controller/AppController.dart';
import '../../../data/models/GameModel.dart';
import '../../../routes/app_pages.dart';
import '../../Control/views/control_view.dart';
import '../../Widgets/Common/SharedWidgets.dart';
import '../../utili/Constants.dart';
import '../controllers/result_controller.dart';

class ResultView extends GetView<ResultController> {
  const ResultView({Key? key}) : super(key: key);
  static const String routeName = Routes.RESULT;

  @override
  Widget build(BuildContext context) {
    Rx<GameModel> gameSession = Get.arguments;
    var c = Get.put(ResultController());
    var ac = Get.put(AppController());

    // var answers = "10";
    return WillPopScope(
      onWillPop: () async {
        // c.pageController.value.dispose();
        return false;
        // return Get.delete<QuizController>();
      },
      child: SafeArea(
        child: Scaffold(
          body: Container(
            padding: const EdgeInsets.all(30),
            child: Center(
              child: Column(
                children: [
                  SharedWidgets().buildCustomAppbar(onPressed: () async {
                    c.gamesList.add(gameSession.value);
                    Logger().d(" c.gamesList : ${c.gamesList.length}");

                    await ac.saveUserGames(c.gamesList);
                    await ac.sendUserScore(
                      gameModel: gameSession.value,
                    );

                    await c.readUserGame(gameSession);
                    Get.offNamed(ControlView.routeName);
                  }),
                  SPACEV10,
                  SPACEV10,
                  SPACEV10,
                  SharedWidgets().buildLogo(),
                  SharedWidgets().buildDesc("Congrats You Have Completed ${gameSession.value.score} "
                      "\n correct answers"),
                  SharedWidgets().buildShareBtn("Share Your Score", mainStyleLW, onPressed: () async {
                    Share.share('I answered ${gameSession.value.score} correct answers in QuizU!');
                    // c.nextQuestion();
                    // c.firstPressSkip.value = true;
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
