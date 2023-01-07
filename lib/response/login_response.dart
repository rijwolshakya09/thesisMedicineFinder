class LoginResponse {
  bool? success;
  String? token;

  LoginResponse({this.success, this.token});

  //Converting Json Data to Dart Object
  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      success: json["success"],
      token: json["token"],
    );
  }

  //Converting Dart Object to Json Data
  Map<String, dynamic> toJson() {
    return {
      "success": success,
      "token": token,
    };
  }
}
