import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:quiz_app/app/data/local/LocalStorage.dart';
import 'package:quiz_app/app/data/models/GameModel.dart';

import '../../IntroScreen/views/intro_screen_view.dart';
import '../service/ProfileService.dart';

class ProfileController extends GetxController {
  var profileService = ProfileService();
  var storage = LocalStorage();
  var name = "".obs;
  var mobile = "".obs;

  var userScoresList = <GameModel>[].obs;

  var isLogged = true.obs;
  var isPlayed = true.obs;

  // fake
  // final List<GameModel> listFromLocal = [GameModel(1, score: 1, userName: "userName", numberOfGames: 1)];

  Future<void> getUsersData() async {
    try {
      var user = await profileService.getUserInfo();
      var _name = user['name'];
      var _mobile = user['mobile'];
      name.value = _name;
      mobile.value = _mobile.toString();
      update();
      Logger().d(name);
    } catch (e) {
      // Logger().d(e);
    }
  }

  Future<bool> getUsersScores() async {
    try {
      final dataFromLocalString = storage.read(key: USER_GAMES);
      final List<GameModel> listFromLocal = GameModel.decode(dataFromLocalString);

      Logger().d("listFromLocal : ${listFromLocal.length}");
      userScoresList.assignAll(listFromLocal);
      Logger().d("userScoresList : ${userScoresList.length}");

      if (dataFromLocalString != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      Logger().d(e);
    }
    return false;
  }

  logOUt() async {
    Logger().d("logOUt : ${isLogged.value}");

    isLogged.value = LocalStorage().isTokenHere();
    if (isLogged.value) {
      await LocalStorage().remove(key: TOKEN);
      Get.offAll(() => const IntroScreenView());
    } else {
      Get.offAll(() => const IntroScreenView());
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
    await getUsersData();
    isPlayed.value = await getUsersScores();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
