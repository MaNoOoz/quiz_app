import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:quiz_app/app/data/local/LocalStorage.dart';
import 'package:quiz_app/app/data/models/GameModel.dart';

import '../../../data/models/ProfileResponseModel.dart';
import '../../../data/services/ProfileService.dart';
import '../../IntroScreen/views/intro_screen_view.dart';

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

  Future<void> getUserInfo() async {
    var json = await profileService.getUserInfo();
    var model = ProfileResponseModel.fromJson(json);
    name.value = model.name!;
    mobile.value = model.mobile!;
  }

  Future<bool> getUserScore() async {
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
    await getUserInfo();
    await getUserScore();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
