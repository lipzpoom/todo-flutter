import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/main.dart';
import 'package:todo/models/user.model.dart';
import 'package:todo/utilities/custom_dialog.dart';
import 'package:todo/utilities/globals.dart';
import 'dart:convert';

class AuthServices {
  final _baseUrl = Globals.api;
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${Globals.token}'
  };
  static late SharedPreferences prefs;
  static Future init() async => prefs = await SharedPreferences.getInstance();

  Future<UserModel> signin(String user, String password) async {
    try {
      var response = await http
          .post(Uri.parse('$_baseUrl/login'),
              body: jsonEncode({'user_email': user, 'user_password': password}),
              headers: headers)
          .timeout(const Duration(seconds: 30));
      if (response.statusCode == 200) {
        var jsonResponseBody = jsonDecode(response.body);
        UserModel parsedData = UserModel.fromJson(jsonResponseBody);
        setDataUser(parsedData);
        return parsedData;
      } else {
        var errMessage = jsonDecode(response.body)['message'] ??
            'Something went wrong.Please contact support.';
        throw errMessage;
      }
    } on SocketException catch (e) {
      CustomDialog.errorDialog(navigatorKey.currentContext!, e.message);
      rethrow;
    } catch (e) {
      CustomDialog.errorDialog(navigatorKey.currentContext!, e.toString());
      rethrow;
    }
  }

  Future<void> saveUserLoggedIn(bool isLoggedIn) async {
    await prefs.setBool('isLoggedIn', isLoggedIn);
  }

  Future<void> setDataUser(UserModel model) async {
    await prefs.setInt('user_id', (model.userId)!.toInt());
    await prefs.setString('user_email', (model.userEmail).toString());
    await prefs.setString('user_fname', (model.userFirstname).toString());
    await prefs.setString('user_lname', (model.userLastname).toString());
    await saveUserLoggedIn(true);
  }

  Future<UserModel> getDataUser() async {
    return UserModel.fromList([
      prefs.getInt('user_id'),
      prefs.getString('user_email'),
      prefs.getString('user_fname'),
      prefs.getString('user_lname'),
    ]);
  }

  Future<void> removeDataUser() async {
    await prefs.remove('user_id');
    await prefs.remove('user_email');
    await prefs.remove('user_fname');
    await prefs.remove('user_lname');
    await saveUserLoggedIn(false);
  }
}
