import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:quiz_app/app/data/local/LocalStorage.dart';

import '../service/ProfileService.dart';

class ProfileController extends GetxController {
  var profileService = ProfileService();
  var storage = LocalStorage();
  var name = "".obs;
  var mobile = "".obs;

  var listOfScores = [
    1,
    5,
    5,
    5,
  ].obs;

  Future<void> getUsersData() async {
    try {
      var a = await profileService.getUserInfo();
      // ProfileResponseModel user = await profileService.getUserInfo();
      // name.value = user.name!;
      // mobile.value = user.mobile!;
      // Logger().d(user.name);
      // Logger().d(user.mobile);
      var _name = a['name'];
      var _mobile = a['mobile'];
      name.value = _name;
      mobile.value = _mobile.toString();
      update();
      Logger().d(name);
    } catch (e) {
      // Logger().d(e);
    }
  }

  Future<void> getUsersScores() async {
    try {
      await storage.saveData(key: USER_SCORES, value: listOfScores);

      // String score = await storage.readProfileData(key: USER_SCORES);
      // listOfScores.add(int.parse(score));
      // Logger().d("${score}");

      // listOfScores.add(int.parse(score));
      // Logger().d(score);
      // Logger().d("${score.runtimeType}");
      Logger().d("${listOfScores.runtimeType}");
    } catch (e) {
      Logger().d(e);
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
    await getUsersScores();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
