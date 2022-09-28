import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:quiz_app/app/modules/Quiz/models/QuestionModel.dart';

import '../../../data/services/QuizService.dart';
import '../../Result/views/result_view.dart';
import '../../utili/Constants.dart';

class QuizController extends GetxController {
  final loadingStatus = LoadingStatus.completed.obs;

  // Page Control ----------------------------------------------------
  var firstPressSkip = true.obs;
  var pageController = PageController(initialPage: 0).obs;

  // ----------------------------------------------------

  /// Data ===================================================================================================
  final questionIndex = 0.obs;
  final allQuestions = <QuestionModel>[];
  QuizService quizService = QuizService();

  bool get isFirstQuestion => questionIndex.value > 0;
  bool get isLastQuestion => questionIndex.value >= allQuestions.length - 1;

  // get all questions
  Future<void> getQuestionsList() async {
    loadingStatus.value = LoadingStatus.loading;
    try {
      var l2 = await quizService.getData();
      var list2 = l2!.map((dynamic element) => QuestionModel.fromJson(element)).toList();
      allQuestions.assignAll(list2);
      loadingStatus.value = LoadingStatus.completed;
    } catch (e) {
      loadingStatus.value = LoadingStatus.error;
      Logger().d(e);
    }
  }

  // Score & Game logic ===============================================================================================
  int _totalScore = 0;
  int get totalScore => _totalScore;
  // double _numberOfQuestion = 1;
  // double get numberOfQuestion => _numberOfQuestion;

  void nextQuestion() {
    Logger().e('nextQuestion ${questionIndex.value}');

    if (questionIndex.value >= allQuestions.length - 1) return;
    questionIndex.value++;
    // add to score
    _totalScore++;
    nextPage();

    Logger().e('questionIndex ${questionIndex.value}');
    Logger().e('_totalScore ${_totalScore}');
  }

  nextPage() {
    Logger().e('nextPage ${questionIndex.value}');
    if (pageController.value.page! >= allQuestions.length - 1) {
      Get.offNamed(ResultView.routeName, arguments: _totalScore); //
    } else {
      pageController.value.nextPage(duration: const Duration(seconds: 1), curve: Curves.easeOut);
    }
    // _numberOfQuestion = pageController.value.page! + 2;
  }

  checkAnswerIfRight({required String inputValue, required QuestionModel model}) {
    Map map = model.toJson();
    var answer = map['correct'];
    var chosenAnswer = map.keys.firstWhere((k) => map[k] == inputValue, orElse: () => "WTF");
    if (chosenAnswer == answer) {
      Logger().e("current score : $_totalScore");

      nextQuestion();
    } else {
      return showTryAgainDialog();
    }
  }

  /// timer ==========================================================================
  static const maxSeconds = 120;
  var seconds = maxSeconds.obs;
  Timer? _timer;

  void startTimer({bool rest = true}) {
    if (rest) {
      resetTimer();
      // update();
    }
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (seconds.value > 0) {
        seconds.value--;
        // update();
      } else if (seconds.value == 0) {
        showEndTimeDialog();
        stopTimer(rest: false);
        resetTimer();
      }
    });
  }

  /// is Timer Completed?
  bool isCompleted() {
    return seconds.value == maxSeconds || seconds.value == 0;
  }

  /// Stop Timer
  void stopTimer({bool rest = true}) {
    if (rest) {
      resetTimer();
      // update();
    }
    _timer?.cancel();
    // update();
  }

  /// Reset Timer
  void resetTimer() {
    seconds.value = maxSeconds;
    // update();
  }

  // Life Cycle =====================================================================================

  void resetAll() {
    pageController.value = PageController(initialPage: 0);
    pageController.value.dispose();
    questionIndex.value = 0;
    _totalScore = 0;
  }

  @override
  void onInit() async {
    super.onInit();
    await getQuestionsList();
    resetAll();
  }

  @override
  void onReady() async {
    super.onReady();
    // timer
    startTimer(rest: false);
  }

  @override
  void onClose() {
    super.onClose();
    if (_timer != null) _timer!.cancel();

    resetAll();
  }
}
