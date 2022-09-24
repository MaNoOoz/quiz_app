import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/app/modules/Quiz/controllers/quiz_controller.dart';
import 'package:quiz_app/app/modules/Quiz/models/QuestionModel.dart';

import '../../Widgets/Common/SharedWidgets.dart';
import '../../utili/Constants.dart';

class QCard extends StatelessWidget {
  QuestionModel model;
  final GestureTapCallback? press;
  final QuizController? c;

  QCard({
    Key? key,
    required this.model,
    this.press,
    this.c,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      margin: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 10),
      decoration: const BoxDecoration(
        // color: Colors.red,

        borderRadius: BorderRadius.all(Radius.circular(8)),
        // border: Border.all(color: Theme.of(context).primaryColor, width: 1.0),
        // boxShadow: [
        // BoxShadow(
        //     color: Colors.black12,
        // blurRadius: 11,
        // offset: Offset(-12, 12)),
        // ],
      ),
      child: Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          textDirection: TextDirection.rtl,
          children: <Widget>[
            SharedWidgets().buildTextRight('${model.question}', mainStyleTW),
            GestureDetector(
              onTap: () {
                c?.checkAnswerIfRight(inputValue: model.a, model: model);
              },
              child: answerRow(
                selectedAnswer: model.a,
              ),
            ),
            GestureDetector(
              onTap: () {
                c?.checkAnswerIfRight(inputValue: model.b, model: model);
              },
              child: answerRow(
                selectedAnswer: model.b,
              ),
            ),
            GestureDetector(
              onTap: () {
                c?.checkAnswerIfRight(inputValue: model.c, model: model);
              },
              child: answerRow(
                selectedAnswer: model.c,
              ),
            ),
            GestureDetector(
              onTap: () {
                c?.checkAnswerIfRight(inputValue: model.d, model: model);
              },
              child: answerRow(
                selectedAnswer: model.d,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget answerRow({
    required String selectedAnswer,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(color: Colors.amber.withOpacity(0.5), blurRadius: 1, offset: Offset(0, 5)),
          ],
        ),
        child: FadeInLeft(
          delay: const Duration(milliseconds: 100),
          // onTap: onTap,
          child: Center(
            child: Text(
              selectedAnswer,
              style: mainStyleTMBL,
            ),
          ),
        ),
      ),
    );
  }
}
