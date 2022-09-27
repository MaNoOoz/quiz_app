import 'package:logger/logger.dart';

import '../provider/ApiProvider.dart';

class AuthService {
  // check user to token
  Future<dynamic> isValidTokenOnServer() async {
    Logger().d("ValidToken Called");
    var endPoint = "Token";
    ApiProvider api = ApiProvider();
    var res = await api.get(endPoint);
    //;
    return res;
  }
}
