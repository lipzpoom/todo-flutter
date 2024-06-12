import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/models/todo.model.dart';
import 'package:todo/models/user.model.dart';
import 'package:todo/services/auth.service.dart';
import 'package:todo/services/todo.service.dart';
import 'package:todo/utilities/colors.dart';
import 'package:todo/widgets/custom_widgets.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  List<TodoModel> itemsTodo = <TodoModel>[];
  UserModel dataUser = UserModel();
  bool isLoading = true;
  SharedPreferences? prefTest;

  @override
  void initState() {
    onInitData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  String uppercaseFirstLetter(String text) {
    if (text.isEmpty) {
      return text;
    }
    return text.substring(0, 1).toUpperCase() + text.substring(1);
  }

  void onInitData() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    isLoading = true;
    if (isLoading) {
      await AuthServices().getDataUser().then((value) {
        dataUser = UserModel(
            userId: value[0],
            userEmail: value[1],
            userFirstname: value[2],
            userLastname: value[3]);
      });
      await TodoService()
          .findAll(pref.getInt('user_id').toString())
          .then((value) => setState(() {
                itemsTodo = value;
                isLoading = false;
              }))
          .catchError((ex) {});
    }
  }

  Future refreshScreen() async {
    onInitData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              child: InkWell(
                onTap: () => showSignOutModalButtom(),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundColor: HexColor('#FBFBFB'),
                      child: Text(
                        dataUser.userFirstname?.substring(0, 1).toUpperCase() ??
                            '',
                        style: TextStyle(
                            color: HexColor('#53CD9F'),
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(width: 9.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          'Hello!',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.0,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          '${uppercaseFirstLetter(dataUser.userFirstname ?? '')} ${uppercaseFirstLetter(dataUser.userLastname ?? '')}',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: isLoading
            ? Center(
                child: CupertinoActivityIndicator(
                  color: AppColors.bgColorItemPrimary,
                ),
              )
            : Container(
                padding: const EdgeInsets.all(20.0),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 20.0),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 8.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.25),
                            spreadRadius: 0,
                            blurRadius: 4,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.search,
                            color: HexColor('#AEAEB2'),
                            size: 27.0,
                          ),
                          const SizedBox(width: 15.0),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Search.......',
                                hintStyle: TextStyle(
                                    color: HexColor('#AEAEB2'),
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: refreshScreen,
                        child: ListView.builder(
                          itemCount: itemsTodo.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10.0)),
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          HexColor('#000000').withOpacity(0.2),
                                      blurRadius: 4,
                                    ),
                                  ],
                                ),
                                height: 130.0,
                                child: Stack(
                                  children: [
                                    Positioned(
                                        right: 0.0,
                                        child: IconButton(
                                          onPressed: () => showMenuModalButtom(
                                              itemsTodo[index].todoListId),
                                          icon: Icon(
                                            Icons.more_horiz,
                                            color: HexColor('#666161')
                                                .withOpacity(0.68),
                                          ),
                                        )),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20.0, horizontal: 10.0),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Icon(
                                            itemsTodo[index]
                                                        .todoListCompleted ==
                                                    'true'
                                                ? Icons.check_circle_rounded
                                                : Icons.circle_outlined,
                                            size: 20.0,
                                            color: HexColor('#1DC9A0'),
                                          ),
                                          const SizedBox(
                                            width: 10.0,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '${itemsTodo[index].todoListTitle}',
                                                  style: TextStyle(
                                                    height: 1,
                                                    fontSize: 20.0,
                                                    fontWeight: FontWeight.w500,
                                                    color: HexColor('#0D7A5C'),
                                                  ),
                                                ),
                                                Text(
                                                  '${itemsTodo[index].todoListLastUpdate}',
                                                  style: TextStyle(
                                                      height: 1.0,
                                                      fontSize: 12.0,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color:
                                                          HexColor('#D9D9D9')),
                                                ),
                                                const SizedBox(
                                                  height: 6.0,
                                                ),
                                                Text(
                                                  '${itemsTodo[index].todoListDesc}',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 3,
                                                  style: TextStyle(
                                                      fontSize: 12.0,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: HexColor('#666161')
                                                          .withOpacity(0.68)),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
      ),
      floatingActionButton: Container(
        width: 66,
        height: 66,
        decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
          BoxShadow(
              offset: const Offset(0, 4),
              blurRadius: 4.0,
              color: Colors.black.withOpacity(0.25))
        ]),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, 'todo-editor');
          },
          backgroundColor: HexColor('#0D7A5C'),
          shape: const CircleBorder(eccentricity: 1.0),
          child: const Image(
            image: Svg('assets/images/calendaradd.svg'),
            width: 40.0,
            height: 40.0,
          ),
        ),
      ),
    );
  }

  void showSignOutModalButtom() {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      builder: (BuildContext context) {
        return Container(
          padding:
              const EdgeInsets.only(top: 23, bottom: 40, left: 30, right: 30),
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'SIGN OUT',
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                    color: HexColor('#473B1E')),
              ),
              Text(
                'Do you want to log out?',
                style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w400,
                    color: HexColor('#473B1E')),
              ),
              const SizedBox(
                height: 60.0,
              ),
              Wrap(
                runSpacing: 20,
                children: [
                  CustomWidgets.buttonMenu(() async {
                    await AuthServices().removeDataUser().then((value) =>
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            'signin', (route) => false));
                  }, 'assets/images/logoutcurve.svg', 'Signout'),
                  Divider(
                    thickness: 1.0,
                    color: HexColor('#D9D9D9').withOpacity(0.3),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void showMenuModalButtom(int? todoId) {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      builder: (BuildContext context) {
        return Container(
          padding:
              const EdgeInsets.only(top: 55, bottom: 80, left: 30, right: 30),
          width: MediaQuery.of(context).size.width,
          child: Wrap(runSpacing: 20, children: [
            CustomWidgets.buttonMenu(
                () => Navigator.of(context).pushNamed('todo-editor'),
                'assets/images/messageedit.svg',
                'Edit'),
            Divider(
              thickness: 1.0,
              color: HexColor('#D9D9D9').withOpacity(0.3),
            ),
            CustomWidgets.buttonMenu(() async {
              await TodoService()
                  .delete(todoId.toString())
                  .then(Navigator.of(context).pop);
              refreshScreen();
            }, 'assets/images/trash.svg', 'Delete'),
          ]),
        );
      },
    );
  }
}
