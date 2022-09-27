import 'dart:convert';
import 'dart:math';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:quiz_app/app/data/models/GameModel.dart';

import '../../modules/utili/Constants.dart';
import '../local/LocalStorage.dart';

class AppController extends GetxController {
  var id = Random().nextInt(500);
  var score = 0;
  var userName = "".obs;
  var numberOfGames = 0;

  final _gamesList = <GameModel>[].obs;

  get gamesList => _gamesList;

  LocalStorage storage = LocalStorage();

  var quizMePressedCounter = 0.obs;

  // count the number of games user played => (quiz me btn counter)
  int gamesCounter() {
    quizMePressedCounter.value++;
    numberOfGames = quizMePressedCounter.value;
    Logger().d("quizMePressedCounter : ${quizMePressedCounter.value}");
    return numberOfGames;
  }

  // new game session
  GameModel newGame() {
    Rx<GameModel> game;
    game = GameModel(id, score: score, userName: userName.value, numberOfGames: numberOfGames).obs;
    return game.value;
  }

  getListOfUserGames() {
    final String dataFromLocalString = storage.read(key: USER_GAMES);
    final List<GameModel> listFromLocal = GameModel.decode(dataFromLocalString);
    _gamesList.assignAll(List.from(listFromLocal));
    return _gamesList;
  }

  List<GameModel> emptyListOfUserGames() {
    var tempEmptylist = <GameModel>[];
    final String encodedData = GameModel.encode(tempEmptylist);
    storage.saveData(key: USER_GAMES, value: encodedData);
    return tempEmptylist;
  }

  Future saveUserGames(List<GameModel> userGamesList) async {
    try {
      emptyListOfUserGames();

      /// getting all saved data
      final oldSavedData = storage.read(key: USER_GAMES);
      if (oldSavedData is String) {
        /// in case there is saved data
        if (oldSavedData != null) {
          /// create a holder list for the old data
          final List<GameModel> listFromLocal = GameModel.decode(oldSavedData);

          // List<dynamic> oldSavedList = jsonDecode(oldSavedData);

          /// append the new list to saved one
          listFromLocal.addAll(userGamesList);

          /// save the new collection
          final String encodedData = GameModel.encode(listFromLocal);
          storage.saveData(key: USER_GAMES, value: encodedData);

          Logger().d("listFromLocal : ${listFromLocal.length}");
        } else {
          /// in case of there is no saved data -- add the new list to storage
          storage.saveData(key: USER_GAMES, value: userGamesList);
        }
      } else {
        Logger().d("خطا في الداتا ستوريج : ${userGamesList.length}");
      }

      Logger().d("userGamesList : ${userGamesList.length}");
    } catch (e) {}

    // //  save game sessions to local storage
    // final String encodedData = GameModel.encode(userGamesList);
    // storage.saveData(key: USER_GAMES, value: encodedData);
  }

  Future<dynamic> sendUserScore({required GameModel gameModel}) async {
    try {
      var _token = LocalStorage().read(key: TOKEN);
      var endPoint = "Score";
      var headers = {
        'Content-Type': 'application/json',
        "Accept": "application/json",
        "Access-Control_Allow_Origin": "*",
        "Authorization": "Bearer $_token",
      };

      var url = "$BASE_URL$endPoint";
      Logger().d(url);

      GameModel.toMap(gameModel);
      var body = jsonEncode({
        'score': '${gameModel.score}',
      });

      var response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: body,
      );
      final data = jsonDecode(response.body);

      if (response.statusCode == 201) {
        var score = data['success'];
        Logger().d("data scented : $score");

        return data;
      }
    } catch (e) {
      Logger().e(e);
    }
  }

  @override
  void onInit() async {
    super.onInit();
  }
}
