import 'dart:convert';

import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:quiz_app/app/data/local/LocalStorage.dart';
import 'package:quiz_app/app/data/models/ScoreModel.dart';

import '../../../data/provider/ApiProvider.dart';

class ResultController extends GetxController {
  List<ScoreModel> scoreList3 = [];

  List<ScoreModel> holderList() {
    var tempEmptylist = <ScoreModel>[];
    final String encodedData = ScoreModel.encode(tempEmptylist);
    LocalStorage().saveData(key: USER_GAMES, value: encodedData);
    return tempEmptylist;
  }

  Future saveScore({required List<ScoreModel> list}) async {
    try {
      holderList();

      /// getting all saved data
      final oldSavedData = LocalStorage().read(key: USER_GAMES);
      if (oldSavedData is String) {
        /// in case there is saved data
        if (oldSavedData != null) {
          /// create a holder list for the old data
          final List<ScoreModel> listFromLocal = ScoreModel.decode(oldSavedData);

          // List<dynamic> oldSavedList = jsonDecode(oldSavedData);

          /// append the new list to saved one
          listFromLocal.addAll(list);

          /// save the new collection
          final String encodedData = ScoreModel.encode(listFromLocal);
          LocalStorage().saveData(key: USER_GAMES, value: encodedData);

          Logger().d("listFromLocal : ${listFromLocal.length}");
        } else {
          /// in case of there is no saved data -- add the new list to storage
          LocalStorage().saveData(key: USER_GAMES, value: list);
        }
      } else {
        Logger().d("خطا في الداتا ستوريج : ${list.length}");
      }

      Logger().d("userGamesList : ${list.length}");
    } catch (e) {
      Logger().e("Error: ${e}");
    }
  }

  Future<dynamic> sendScore({required String score}) async {
    ApiProvider api = ApiProvider();
    var endPoint = "Score";
    var body = jsonEncode({
      'score': '$score',
    });

    var res = await api.post(endPoint, body: body);
    //;
    return res;
  }
}
