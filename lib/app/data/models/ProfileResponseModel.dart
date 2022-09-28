class ProfileResponseModel {
  String? name;
  String? mobile;

  ProfileResponseModel.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    mobile = json["mobile"];
  }
  Map<String, dynamic> toJson() => {
        "name": name,
        "mobile": mobile,
      };
}
