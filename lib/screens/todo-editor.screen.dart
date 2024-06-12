import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:todo/models/todo.model.dart';
import 'package:todo/models/user.model.dart';
import 'package:todo/services/auth.service.dart';
import 'package:todo/utilities/colors.dart';
import 'package:todo/widgets/custom_widgets.dart';

class TodoEditorScreen extends StatefulWidget {
  const TodoEditorScreen({super.key});

  @override
  State<TodoEditorScreen> createState() => _TodoEditorScreenState();
}

class _TodoEditorScreenState extends State<TodoEditorScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _todoTitleController = TextEditingController();
  final TextEditingController _todoDescController = TextEditingController();
  bool isProgessSwitch = false;

  TodoModel itemTodo = TodoModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  HexColor('#4CC599'),
                  HexColor('#0D7A5C'),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  offset: const Offset(0, 4),
                  blurRadius: 4.0,
                ),
              ],
            ),
            child: Container(
              padding: const EdgeInsets.only(top: 42, bottom: 20, left: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamedAndRemoveUntil('todo', (route) => false);
                    },
                    child: Image.asset(
                      'assets/images/arrowleft.png',
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 9.0),
                  const Text(
                    'Add Your Todo',
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textForeground),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          padding: const EdgeInsets.all(20.0),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Wrap(
                runSpacing: 10.0,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 8.0),
                    decoration: CustomWidgets.inputDecoration(),
                    child: TextFormField(
                      controller: _todoTitleController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your title';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Title',
                        hintStyle: TextStyle(
                            color: HexColor('#666161').withOpacity(0.68),
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  Container(
                    height: 166,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 8.0),
                    decoration: CustomWidgets.inputDecoration(),
                    child: TextFormField(
                      controller: _todoDescController,
                      maxLines: 1000,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your title';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Description',
                        hintStyle: TextStyle(
                            color: HexColor('#666161').withOpacity(0.68),
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 20.0),
                    decoration: CustomWidgets.inputDecoration(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Success',
                          style: TextStyle(
                              color: AppColors.primaryColor,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500),
                        ),
                        CupertinoSwitch(
                          value: isProgessSwitch,
                          activeColor: AppColors.bgColorItemPrimary,
                          onChanged: (value) {
                            setState(() {
                              isProgessSwitch = value;
                            });
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration:
                    CustomWidgets.gradientDecoration('#0D7A5C', '#53CD9F'),
                child: CustomWidgets.buttonStyle(() {
                  onCreate();
                }, 'Save'),
              )
            ],
          ),
        ),
      ),
    );
  }

  void onCreate() async {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      itemTodo.todoListTitle = _todoTitleController.text;
      itemTodo.todoListDesc = _todoDescController.text;
      itemTodo.todoListCompleted = isProgessSwitch.toString();
      final userId =
          AuthServices().getDataUser().then((data) => UserModel.fromList(data));
      inspect(userId);
    }
  }
}