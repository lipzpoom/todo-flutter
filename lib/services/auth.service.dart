import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/models/user.model.dart';
import 'package:todo/utilities/globals.dart';
import 'dart:convert';

class AuthServices {
  final _baseUrl = Globals.api;
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${Globals.token}'
  };

  Future<UserModel> signin(String user, String password) async {
    try {
      var response = await http.post(Uri.parse('$_baseUrl/login'),
          body: jsonEncode({'user_email': user, 'user_password': password}),
          headers: headers);
      if (response.statusCode == 200) {
        var jsonResponseBody = jsonDecode(response.body);
        UserModel parsedData = UserModel.fromJson(jsonResponseBody);

        return parsedData;
      } else {
        throw 'Signin Failed';
      }
    } catch (e) {
      print('error = ${e.toString()}');
      rethrow;
    }
  }

  Future<void> setDataUser(UserModel model) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('user_id', (model.userId)!.toInt());
    await prefs.setString('user_email', (model.userEmail).toString());
    await prefs.setString('user_fname', (model.userFirstname).toString());
    await prefs.setString('user_lname', (model.userLastname).toString());
  }

  Future<List<dynamic>> getDataUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return [
      prefs.getInt('user_id'),
      prefs.getString('user_email'),
      prefs.getString('user_fname'),
      prefs.getString('user_lname'),
    ];
  }

  Future<void> removeDataUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_id');
    await prefs.remove('user_email');
    await prefs.remove('user_fname');
    await prefs.remove('user_lname');
  }
}
