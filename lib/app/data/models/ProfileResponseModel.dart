class ProfileResponseModel {
  String? name;
  String? mobile;

  ProfileResponseModel.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    mobile = json["mobile"];
  }
}
