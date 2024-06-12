class UserModel {
  int? userId;
  String? userEmail;
  String? userPassword;
  String? userFirstname;
  String? userLastname;

  UserModel({
    this.userId,
    this.userEmail,
    this.userPassword,
    this.userFirstname,
    this.userLastname,
  });

  factory UserModel.fromJson(Map<String, dynamic> parsedJson) {
    try {
      return UserModel(
        userId: parsedJson['user_id'],
        userEmail: parsedJson['user_email'],
        userPassword: parsedJson['user_password'],
        userFirstname: parsedJson['user_fname'],
        userLastname: parsedJson['user_lname'],
      );
    } catch (e) {
      print('UserModel ====> $e');
      throw ('factory UserModel.fromJson ====> $e');
    }
  }

  factory UserModel.fromList(List<dynamic> data) {
    return UserModel(
      userId: data[0],
      userEmail: data[1],
      userFirstname: data[2],
      userLastname: data[3],
    );
  }

  Map<String, dynamic> toJson() => {
        'user_id': userId,
        'user_email': userEmail,
        'user_password': userPassword,
        'user_fname': userFirstname,
        'user_lname': userLastname,
      };
}
