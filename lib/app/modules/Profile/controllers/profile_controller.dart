import 'dart:convert';

import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:quiz_app/app/data/local/LocalStorage.dart';
import 'package:quiz_app/app/data/models/ScoreModel.dart';

import '../../../data/models/ProfileResponseModel.dart';
import '../../../data/services/ProfileService.dart';
import '../../IntroScreen/views/intro_screen_view.dart';

class ProfileController extends GetxController {
  var profileService = ProfileService();
  var storage = LocalStorage();
  var name = "".obs;
  var mobile = "".obs;

  var userScoresList = <ScoreModel>[].obs;

  var isLogged = true.obs;

  Future<void> getUserInfo() async {
    var json = await profileService.getUserInfo();
    ProfileResponseModel model = ProfileResponseModel.fromJson(json);
    String jsonString = jsonEncode(model);
    LocalStorage().saveData(key: USER_INFO, value: jsonString);
    name.value = model.name!;
    mobile.value = model.mobile!;
  }

  getUserScores() {
    final dataFromLocalString = LocalStorage().read(key: USER_GAMES);
    if (dataFromLocalString is String) {
      final List<ScoreModel> listFromLocal = ScoreModel.decode(dataFromLocalString);
      userScoresList.addAll(listFromLocal);
      userScoresList.refresh();
      return userScoresList;
    } else {
      return [];
    }
  }

  logOUt() async {
    Logger().d("logOUt : ${isLogged.value}");

    isLogged.value = LocalStorage().isTokenHere();
    if (isLogged.value) {
      await LocalStorage().remove(key: TOKEN);
      await LocalStorage().remove(key: USER_GAMES);
      Get.offAll(() => const IntroScreenView());
    } else {
      Get.offAll(() => const IntroScreenView());
    }
  }

  @override
  void onReady() async {
    super.onReady();
    await getUserInfo();
    await getUserScores();
  }
}
