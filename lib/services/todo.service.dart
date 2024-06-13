import 'dart:developer';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:todo/models/todo.model.dart';
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
      return await http.post(
        Uri.parse('$_baseUrl/create_todo'),
        body: jsonEncode(data),
        headers: headers,
      );
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  Future<http.Response?> update(TodoModel model) async {
    try {
      var data = model.toJson();
      return await http.post(
        Uri.parse('$_baseUrl/update_todo'),
        body: jsonEncode(data),
        headers: headers,
      );
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  Future<http.Response?> delete(String todoId) async {
    return await http.delete(Uri.parse('$_baseUrl/delete_todo/$todoId'),
        headers: headers);
  }

  Future<List<TodoModel>> findAll(String userId) async {
    var response = await http.get(Uri.parse('$_baseUrl/todo_list/$userId'),
        headers: headers);
    if (response.statusCode == 200) {
      return parseData(response.body);
    } else {
      return <TodoModel>[];
    }
  }

  List<TodoModel> parseData(String responseBody) {
    final jsonMapDecode = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return jsonMapDecode
        .map<TodoModel>((json) => TodoModel.fromJson(json))
        .toList();
  }
}
