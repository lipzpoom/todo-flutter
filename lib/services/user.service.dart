import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:todo/main.dart';
import 'dart:convert';
import 'package:todo/models/user.model.dart';
import 'package:todo/utilities/custom_dialog.dart';
import 'package:todo/utilities/globals.dart';

class UserService {
  final _baseUrl = Globals.api;
  var headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${Globals.token}'
  };

  Future<http.Response?> create(UserModel model) async {
    try {
      var data = model.toJson();
      var response = await http
          .post(
            Uri.parse('$_baseUrl/create_user'),
            body: jsonEncode(data),
            headers: headers,
          )
          .timeout(const Duration(seconds: 30));
      if (response.statusCode == 200 && response.body == 'OK') {
        return response;
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
}
