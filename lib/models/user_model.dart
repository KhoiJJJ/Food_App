import 'dart:convert';

List<UserModel> UserModelFromJson(String str) =>
    List<UserModel>.from(json.decode(str).map((x) => UserModel.fromJson(x)));

String UserModelToJson(List<UserModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserModel {
  String id;
  String? image;
  String name;
  String email;

  UserModel({
    required this.id,
    this.image,
    required this.name,
    required this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      id: json["id"],
      image: json["image"],
      name: json["name"],
      email: json["email"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "name": name,
        "email": email,
      };
}
