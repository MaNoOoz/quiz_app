import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:quiz_app/app/data/models/UserResponseModel.dart';

import '../../../data/services/LeaderboardService.dart';
import '../../utili/Constants.dart';

class LeaderboardController extends GetxController {
  final loadingStatus = LoadingStatus.completed.obs;
  var leaderService = LeaderboardService();
  List<UserModel> allUsers = <UserModel>[].obs;

  Future<void> getTopUsers() async {
    loadingStatus.value = LoadingStatus.loading;
    try {
      var l = await leaderService.getTopUsers();
      var list2 = l!.map((dynamic element) => UserModel.fromJson(element)).toList();
      allUsers.assignAll(list2);
      loadingStatus.value = LoadingStatus.completed;
    } catch (e) {
      loadingStatus.value = LoadingStatus.error;
      Logger().e(e);
    }
  }

  @override
  void onInit() async {
    super.onInit();
    await getTopUsers();
  }

  @override
  void onReady() async {
    super.onReady();
    await getTopUsers();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
