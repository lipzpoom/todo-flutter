class TodoModel {
  int? todoListId;
  int? userId;
  String? todoListTitle;
  String? todoListDesc;
  String? todoListCompleted;
  String? todoListLastUpdate;
  int? todoTypeId;
  String? todoTypeName;

  TodoModel({
    this.todoListId,
    this.userId,
    this.todoListTitle,
    this.todoListDesc,
    this.todoListCompleted,
    this.todoListLastUpdate,
    this.todoTypeId,
    this.todoTypeName,
  });

  factory TodoModel.fromJson(Map<String, dynamic> parsedJson) {
    try {
      return TodoModel(
        todoListId: parsedJson['user_todo_list_id'],
        userId: parsedJson['userId'],
        todoListTitle: parsedJson['user_todo_list_title'],
        todoListDesc: parsedJson['user_todo_list_desc'],
        todoListCompleted: parsedJson['user_todo_list_completed'],
        todoListLastUpdate: parsedJson['user_todo_list_last_update'],
        todoTypeId: parsedJson['user_todo_type_id'],
        todoTypeName: parsedJson['user_todo_type_name'],
      );
    } catch (e) {
      print('UserModel ====> $e');
      throw ('factory UserModel.fromJson ====> $e');
    }
  }

  Map<String, dynamic> toJson() => {
        'user_todo_list_id': todoListId,
        'user_id': userId,
        'user_todo_list_title': todoListTitle,
        'user_todo_list_desc': todoListDesc,
        'user_todo_list_completed': todoListCompleted,
        'user_todo_list_last_update': todoListLastUpdate,
        'user_todo_type_id': todoTypeId,
        'user_todo_type_name': todoTypeName,
      };
}
