import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:quiz_app/app/data/app_controller/AppController.dart';
import 'package:quiz_app/app/data/models/GameModel.dart';
import 'package:quiz_app/app/modules/Quiz/models/QuestionModel.dart';

import '../../../data/services/QuizService.dart';
import '../../Result/views/result_view.dart';
import '../../utili/Constants.dart';

class QuizController extends GetxController {
  final loadingStatus = LoadingStatus.completed.obs;

  // Page Control ----------------------------------------------------
  var firstPressSkip = true.obs;
  final questionIndex = 0.obs;
  final page = 0.obs;
  var pageController = PageController(initialPage: 0).obs;

  onPageChanged(int val) {
    page.value = val;
    questionIndex.value = val;

    Logger().e(page.value.toString());
    // Logger().e(controller.questionIndex.toString());
    // Logger().e(controller.isFirstPage.toString());
    // Logger().e(controller.totalScore.toString());
  }

  resetPageController(int page) {
    pageController.value = PageController(initialPage: page);
  }

  bool get isFirstPage {
    return page.value == 0;
  }

  bool get isLastPage {
    return page.value == allQuestions.length - 1;
  }

  // ----------------------------------------------------

  /// Data ===================================================================================================
  Rxn<QuestionModel> currentQuestion = Rxn<QuestionModel>();
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
  int? selectedOption = -1;

  int get totalScore => _totalScore;
  late Rx<GameModel> gameSession;
  List<Icon> iconsScoreList = [];

  void resetAll() {
    pageController.value = PageController(initialPage: 0);
    pageController.value.dispose();
    currentQuestion.value = allQuestions[0];
    questionIndex.value = 0;
    currentQuestion.value = allQuestions[0];
    if (_timer != null) _timer!.cancel();
  }

  void nextQuestion() {
    Logger().d('nextQuestion ${questionIndex.value}');
    nextPage();

    if (questionIndex.value >= allQuestions.length - 1) return;
    questionIndex.value++;
    // page.value++;
    currentQuestion.value = allQuestions[questionIndex.value];
    // page.value = allQuestions.indexOf(currentQuestion.value);
  }

  nextPage() {
    Logger().d('nextQuestion $nextQuestion');
    if (page.value >= allQuestions.length - 1) {
      Get.toNamed(ResultView.routeName, arguments: gameSession); //

    } else {
      pageController.value.nextPage(duration: const Duration(seconds: 1), curve: Curves.easeOut);
    }

    // if (pageController.value.hasClients) {
    // }
  }

  checkAnswerIfRight({required String inputValue, required QuestionModel model}) {
    // Map<int, int> selectedAnswers = {};
    // int questionNumber = 0;

    Map map = model.toJson();
    // Logger().d('$map');

    // bring the key for correct answer:
    var answer = map['correct'];
    // var chosenAnswer = map['correct'];
    // Logger().d('$answer');
    var chosenAnswer = map.keys.firstWhere((k) => map[k] == inputValue, orElse: () => "WTF");

    // Logger().d('chosenAnswer $chosenAnswer');

    if (chosenAnswer == answer) {
      // add to score
      _totalScore++;
      // add score to object
      gameSession.update((val) {
        val?.score = _totalScore;
        val?.numberOfGames = AppController().gamesCounter();
      });

      // Logger().e('current score $_totalScore');
      // Logger().e('gameObject score${gameSession.value.score}');
      // Logger().e('gameObject numberOfGames ${gameSession.value.numberOfGames}');

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

  var stream = Duration(seconds: 3).obs;

  // Life Cycle =====================================================================================

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
    resetAll();
  }
}
