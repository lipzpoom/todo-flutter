import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:todo/main.dart';
import 'package:todo/models/todo.model.dart';
import 'package:todo/utilities/custom_dialog.dart';
import 'package:todo/utilities/globals.dart';

class TodoService {
  final _baseUrl = Globals.api;
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${Globals.token}'
  };

  Future<http.Response?> create(TodoModel model) async {
    try {
      var data = model.toJson();
      var response = await http
          .post(
            Uri.parse('$_baseUrl/create_todo'),
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

  Future<http.Response?> update(TodoModel model) async {
    try {
      var data = model.toJson();
      var response = await http
          .post(
            Uri.parse('$_baseUrl/update_todo'),
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

  Future<http.Response?> delete(String todoId) async {
    try {
      var response = await http
          .delete(Uri.parse('$_baseUrl/delete_todo/$todoId'), headers: headers)
          .timeout(const Duration(seconds: 30));
      if (response.statusCode == 200) {
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

  Future<List<TodoModel>> findAll(String userId) async {
    try {
      var response = await http
          .get(Uri.parse('$_baseUrl/todo_list/$userId'), headers: headers)
          .timeout(const Duration(seconds: 30));
      if (response.statusCode == 200) {
        return parseData(response.body);
      } else {
        return <TodoModel>[];
      }
    } on SocketException catch (e) {
      CustomDialog.errorDialog(navigatorKey.currentContext!, e.message);
      rethrow;
    } catch (e) {
      CustomDialog.errorDialog(navigatorKey.currentContext!, e.toString());
      rethrow;
    }
  }

  List<TodoModel> parseData(String responseBody) {
    final jsonMapDecode = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return jsonMapDecode
        .map<TodoModel>((json) => TodoModel.fromJson(json))
        .toList();
  }
}
