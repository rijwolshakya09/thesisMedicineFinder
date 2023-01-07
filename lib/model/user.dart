class User {
  String? username;
  String? contact_no;
  String? email;
  String? password;

  User({
    this.username,
    this.contact_no,
    this.email,
    this.password,
  });

  //Converting Json Data to Dart Object
  factory User.fromJson(Map<String, dynamic> json) => User(
        username: json["username"],
        contact_no: json["contact_no"],
        email: json["email"],
        password: json["password"],
      );

  //Converting Dart Object to Json Data
  Map<String, dynamic> toJson() => {
        "username": username,
        "contact_no": contact_no,
        "email": email,
        "password": password,
      };
}
