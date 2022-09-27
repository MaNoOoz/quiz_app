import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../../data/app_controller/AppController.dart';
import '../../../data/local/LocalStorage.dart';
import '../../../data/models/GameModel.dart';
import '../../Quiz/views/quiz_view.dart';

class HomeController extends GetxController {
  final userName = ''.obs;
  getUserName() {
    var user = LocalStorage().ModelFromLoginData(key: USER_INFO);
    userName.value = user.name ?? " There ..";
    Logger().d("user : ${userName.value}");

    Logger().d(USER_INFO);
  }

  // main method to start the game:
  startGame() async {
    var appTracker = Get.put(AppController());

    var _numberOfGames = appTracker.gamesCounter();

    Rx<GameModel> gameSession = appTracker.newGame().obs;

    Logger().d("gameSession : ${gameSession.value.numberOfGames}");

    gameSession.update((val) {
      val?.numberOfGames = _numberOfGames;
    });

    Get.toNamed(QuizView.routeName, arguments: gameSession);
  }

  @override
  onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
