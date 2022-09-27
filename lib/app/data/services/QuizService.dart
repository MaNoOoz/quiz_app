import '../provider/ApiProvider.dart';

class QuizService {
  Future<List<dynamic>?> getData() async {
    var endPoint = "Questions";
    ApiProvider api = ApiProvider();
    var res = await api.get(endPoint);
    //;
    return res;
  }
}
