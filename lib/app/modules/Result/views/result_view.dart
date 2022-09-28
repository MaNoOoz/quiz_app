import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/app/data/models/ScoreModel.dart';
import 'package:share_plus/share_plus.dart';

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
    final score = Get.arguments;
    var c = Get.put(ResultController());

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          body: Container(
            padding: const EdgeInsets.all(30),
            child: Center(
              child: Column(
                children: [
                  SharedWidgets().buildCustomAppbar(onPressed: () async {
                    ScoreModel scoreModel =
                        ScoreModel(score: score.toString(), dateOfGame: DateTime.now().toIso8601String().toString());
                    c.scoreList3.add(scoreModel);
                    await c.sendScore(score: score.toString());
                    await c.saveScore(list: c.scoreList3);

                    Get.offNamed(ControlView.routeName);
                  }),
                  SPACEV10,
                  SPACEV10,
                  SPACEV10,
                  SharedWidgets().buildLogo(),
                  SharedWidgets().buildDesc("Congrats You Have Completed ${score} "
                      "\n correct answers"),
                  SharedWidgets().buildShareBtn("Share Your Score", mainStyleLW, onPressed: () async {
                    Share.share('I answered ${score} correct answers in QuizU!');
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
