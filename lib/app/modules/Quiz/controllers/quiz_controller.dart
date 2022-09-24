import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:quiz_app/app/data/local/LocalStorage.dart';
import 'package:quiz_app/app/modules/Quiz/models/QuestionModel.dart';
import 'package:quiz_app/app/modules/Result/views/result_view.dart';

import '../services/QuizService.dart';

class QuizController extends GetxController {
  var firstPressSkip = false.obs;
  final questionIndex = 0.obs;

  final page = 0.obs;
  var pageController = PageController(initialPage: 0).obs;

  onPageChanged(input) {
    page.value = input;
  }

  resetController(int page) {
    pageController.value = PageController(initialPage: page);
  }

  bool get isFirstPage {
    return page.value == 0;
  }

  bool get isLastPage {
    return page.value == listOfQuestions.length - 1;
  }

  Rxn<QuestionModel> currentQuestion = Rxn<QuestionModel>();

  /// Data ===================================================================================================
  QuizService quizService = QuizService();
  LocalStorage storage = LocalStorage();
  List<QuestionModel> listOfQuestions = <QuestionModel>[].obs;

  Future<void> getQuestionsList() async {
    try {
      var l = await quizService.getData();
      var list = l!.map((dynamic element) => QuestionModel.fromJson(element)).toList();
      listOfQuestions.assignAll(list);
    } catch (e) {
      Logger().d(e);
    }
  }

  // Score & Game logic ===============================================================================================

  int _totalScore = 0;

  int get totalScore => _totalScore;
  List<Icon> iconsScoreList = [];
  List<String> ScoreList = ["55", "66"];

  readScoreFromLocal() async {
    Logger().d('readList $readScoreFromLocal');
    return storage.readScore(key: USER_SCORES2);
  }

  saveScoresToLocalStorage() async {
    Logger().d('saveScoresToLocalStorage $saveScoresToLocalStorage');
    final testList = await storage.saveScore(storageKey: USER_SCORES2, storageValue: ScoreList);

    /// getting all saved data
    final oldSavedData = await storage.readScore(key: USER_SCORES2);
    Logger().d('oldSavedData $oldSavedData');

    /// in case there is saved data
    if (oldSavedData != null) {
      /// create a holder list for the old data
      List<dynamic> oldSavedList = jsonDecode(oldSavedData);

      /// append the new list to saved one
      oldSavedList.addAll(ScoreList);

      /// save the new collection
      return storage.saveScore(storageKey: USER_SCORES, storageValue: oldSavedList);
    } else {
      /// in case of there is no saved data -- add the new list to storage
      return storage.saveScore(storageKey: USER_SCORES, storageValue: ScoreList);
    }
  }

  rightAnswers() {
    var answeredScore = false;
    iconsScoreList.add(answeredScore
        ? Icon(
            Icons.brightness_1,
            color: Colors.green,
          )
        : Icon(Icons.brightness_1_outlined));
  }

  restScore() {
    _totalScore = 0;
    iconsScoreList = [];
    // page.value = 0;
    resetController(0);
    restTimer();
  }

  void resetAll() {
    questionIndex.value = 0;
    currentQuestion.value = listOfQuestions[0];
    // page.value = 0;
    // pageController.jumpToPage(0);
  }

  void nextQuestion() async {
    Logger().d('nextQuestion $nextQuestion');

    if (page.value + 1 == listOfQuestions.length) {
      Get.toNamed(ResultView.routeName, arguments: _totalScore); //
    }
    if (pageController.value.hasClients) {
      pageController.value.nextPage(duration: const Duration(seconds: 1), curve: Curves.easeOut);
    }
  }

  checkAnswerIfRight({required String inputValue, required QuestionModel model}) {
    // Map<int, int> selectedAnswers = {};
    // int questionNumber = 0;

    Map map = model.toJson();
    Logger().d('$map');

    // bring the key for correct answer:
    var answer = map['correct'];
    // var chosenAnswer = map['correct'];
    Logger().d('$answer');
    var chosenAnswer = map.keys.firstWhere((k) => map[k] == inputValue, orElse: () => "WTF");
    // map.forEach((k, v) => print('${k}: ${v}'));

    Logger().d('chosenAnswer $chosenAnswer');
    // Logger().e('current score $_totalScore');

    if (chosenAnswer == answer) {
      // add to score
      _totalScore++;
      Logger().e('current score $_totalScore');

      nextQuestion();
    } else {
      return showTryAgainDialog();
    }
  }

  /// timer ==========================================================================
  var maxSeconds = const Duration(seconds: 120);
  final time = '00:00'.obs;
  Timer? _timer;
  int remainSeconds = 1;
  var isRunning = false;

  _startQuiz() {
    _startTimer();
  }

  void restTimer() => remainSeconds = maxSeconds.inSeconds;

  stopTimer({bool reset = true}) {
    _timer?.cancel();
  }

  pauseTimer() {
    isRunning = _timer == null ? false : _timer!.isActive;
    stopTimer();
  }

  /// is Timer Completed?
  bool isCompleted() {
    var finished = int.parse(time.value) == maxSeconds.inSeconds || int.parse(time.value) == 0;
    Logger().d('finished $finished');

    return finished;
  }

  String towDigits(int num) {
    return num.toString().padLeft(2, '0');
  }

  String formatedTime({required input}) {
    final minutes = towDigits(maxSeconds.inMinutes.remainder(60));
    final seconds = towDigits(maxSeconds.inSeconds.remainder(60));
    time.value = input.toString();
    return time.value = "$minutes:$seconds";
  }

  void _startTimer({bool reset = true}) {
    const duration = Duration(seconds: 1);

    if (reset) {
      restTimer();
    }
    remainSeconds = maxSeconds.inSeconds;
    _timer = Timer.periodic(
      duration,
      (Timer timer) {
        if (remainSeconds == 0) {
          showEndTimeDialog();
          stopTimer(reset: false);
        } else {
          remainSeconds--;
          formatedTime(input: remainSeconds);
        }
      },
    );
  }

  /// Dialogs ==========================================================================

  showTryAgainDialog() {
    Get.defaultDialog(
      title: "Try Again",
    );
  }

  showEndTimeDialog() {
    Get.defaultDialog(
      title: "Time is Over",
    );
  }

  // Life Cycle =====================================================================================
  @override
  void onInit() async {
    super.onInit();
    _startQuiz();
  }

  @override
  void onReady() async {
    super.onReady();
    await getQuestionsList();
  }

  @override
  void onClose() {
    super.onClose();
    if (_timer != null) {
      _timer!.cancel();
    }
    restScore();
    resetAll();
    pageController.value.dispose();
  }
}
