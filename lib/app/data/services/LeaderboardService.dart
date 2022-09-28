import '../provider/ApiProvider.dart';

class LeaderboardService {
  Future<List<dynamic>?> getTopUsers() async {
    var endPoint = "TopScores";
    ApiProvider api = ApiProvider();
    var res = await api.get(endPoint);
    return res;
  }
}
