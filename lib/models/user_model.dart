import 'dart:convert';

List<UserModel> UserModelFromJson(String str) =>
    List<UserModel>.from(json.decode(str).map((x) => UserModel.fromJson(x)));

String UserModelToJson(List<UserModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserModel {
  String name;
  String id;
  String? image;
  String phone;

  String email;

  UserModel({
    required this.id,
    this.image,
    required this.name,
    required this.email,
    required this.phone,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      name: json["name"],
      id: json["id"],
      image: json["image"],
      email: json["email"],
      phone: json["phone"],);

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
        "image": image,
        "email": email,
        "phone": phone,
      };
}
