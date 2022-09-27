class LoginResponseModel {
  String? name;
  String? mobile;
  String? token;
  String? msg;
  bool? success;

  // LoginResponseModel();

  LoginResponseModel({this.name, this.mobile, this.token, this.msg, this.success});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    mobile = json["mobile"];
    token = json["token"];
    msg = json["msg"];
    success = json["success"];
  }

  Map<String, dynamic> toJson() => {
        "success": success,
        "msg": msg,
        "token": token,
        "name": name,
        "mobile": mobile,
      };
}
