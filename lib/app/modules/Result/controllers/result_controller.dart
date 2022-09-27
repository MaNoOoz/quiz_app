import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../../data/local/LocalStorage.dart';
import '../../../data/models/GameModel.dart';

class ResultController extends GetxController {
  List<GameModel> gamesList = [];

  // save  Game Session to local storage
  Future<void> saveUserGame(Rx<GameModel> gameSession) async {}

  Future readUserGame(Rx<GameModel> gameSession) async {
    var ss = await LocalStorage().read(
      key: USER_GAMES,
    );
    Logger().d("readUserGame : $ss");
  }

  final count = 0.obs;
  @override
  void onInit() {
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

  void increment() => count.value++;
}
