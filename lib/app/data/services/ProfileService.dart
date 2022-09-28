import '../provider/ApiProvider.dart';

class ProfileService {
  Future<dynamic> getUserInfo() async {
    // Logger().d("getUserInfo2 Called");
    var endPoint = "UserInfo";
    ApiProvider api = ApiProvider();
    var res = await api.get(endPoint);
    //;
    return res;
  }
}
