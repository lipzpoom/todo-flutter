import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:todo/models/user.model.dart';
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
      return await http.post(
        Uri.parse('$_baseUrl/create_user'),
        body: jsonEncode(data),
        headers: headers,
      );
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  // Future<UserModel> findOne(String userId) async {
  //   try {
  //     var response = await http.get(
  //       Uri.parse('$_baseUrl/$userId'),
  //       headers: headers,
  //     );
  //     if (response.statusCode == 200) {
  //       var jsonResponseBody = jsonDecode(response.body);
  //       return UserModel.fromJson(jsonResponseBody);
  //     } else {
  //       throw Exception('Failed to load user');
  //     }
  //   } catch (e) {
  //     print(e.toString());
  //     throw Exception('Error fetching user');
  //   }
  // }

  // List<UserModel> parseJsonData(String responseBody) {
  //   final parsed = jsonDecode(responseBody)<Map<String, dynamic>>();
  //   return parsed.map<UserModel>((json) => UserModel.fromJson(json)).toList();
  // }
}
