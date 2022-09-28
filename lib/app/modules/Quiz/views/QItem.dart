import 'package:animate_do/animate_do.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/app/data/models/QuestionModel.dart';
import 'package:quiz_app/app/modules/Quiz/controllers/quiz_controller.dart';

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
    return SizedBox(
      height: 500,
      child: ListView(
        children: <Widget>[
          SizedBox(height: 100, child: SharedWidgets().buildTextRight('${model.question}', mainTitleBlack)),
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
    );
  }

  Widget answerRow({
    required String selectedAnswer,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 75,
        child: Container(
          margin: const EdgeInsets.fromLTRB(8, 0, 8, 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(8)),
            border: Border.all(color: Colors.black54),
            // boxShadow: [
            //   BoxShadow(color: Colors.black54.withOpacity(0.1), blurRadius: 1, offset: Offset(0, 5)),
            // ],
          ),
          child: FadeInLeft(
            delay: const Duration(milliseconds: 100),
            // onTap: onTap,
            child: Center(
              child: AutoSizeText(
                selectedAnswer,
                maxFontSize: 40.0,
                minFontSize: 16.0,
                style: mainStyleTMBL,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
