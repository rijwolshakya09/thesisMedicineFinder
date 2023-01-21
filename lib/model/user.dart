import 'package:json_annotation/json_annotation.dart';

class User {
  @JsonKey(name: '_id')
  String? id;
  String? username;
  String? contact_no;
  String? email;
  String? password;
  String? userType;

  User({
    this.username,
    this.contact_no,
    this.email,
    this.password,
    this.id,
    this.userType,
  });

  //Converting Json Data to Dart Object
  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        username: json["username"],
        contact_no: json["contact_no"],
        email: json["email"],
        password: json["password"],
        userType: json["userType"],
      );

  //Converting Dart Object to Json Data
  Map<String, dynamic> toJson() => {
        "username": username,
        "contact_no": contact_no,
        "email": email,
        "password": password,
        "_id": id,
        "userType": userType,
      };
}
