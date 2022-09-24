import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../services/LeaderboardService.dart';

class LeaderboardController extends GetxController {
  //TODO: Implement LeaderboardController
  var leaderService = LeaderboardService();
  List<dynamic> listOfUsers = <dynamic>[].obs;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
    await getTopUsersData();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  Future<void> getTopUsersData() async {
    try {
      var l = await leaderService.getTopUsers();
      Logger().d(l);

      var list = l!.toList();
      listOfUsers.assignAll(list);
    } catch (e) {
      // Logger().d(e);
    }
  }
}
