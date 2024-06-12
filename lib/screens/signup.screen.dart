import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:todo/models/user.model.dart';
import 'package:todo/services/user.service.dart';
import 'package:todo/utilities/colors.dart';
import 'package:todo/widgets/custom_widgets.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  UserModel userModel = UserModel();

  final TextEditingController userFirstNameController = TextEditingController();
  final TextEditingController userLastNameController = TextEditingController();
  final TextEditingController userEmailController = TextEditingController();
  final TextEditingController userPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/background.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  margin: const EdgeInsets.only(
                      top: 60.0, bottom: 8.0, right: 8.0, left: 8.0),
                  child: Column(children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          left: 0.0,
                          child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Image.asset(
                                'assets/images/arrowleft.png',
                                fit: BoxFit.cover,
                              )),
                        ),
                        Center(
                          child: Text(
                            "SIGN UP",
                            style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w500,
                                color: AppColors.textPrimary),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 19.0,
                    ),
                    SizedBox(
                        width: 250,
                        child: Text(
                          textAlign: TextAlign.center,
                          "Please enter the information below to access.",
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w400,
                              color: AppColors.textPrimary),
                        )),
                    const SizedBox(height: 35.0),
                    const Image(image: Svg("assets/images/signup.svg")),
                    const SizedBox(height: 35.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 45),
                      child: Wrap(
                        runSpacing: 20.0,
                        children: [
                          CustomWidgets.textFieldInputDecoration(
                              userFirstNameController,
                              false,
                              'First name',
                              null),
                          CustomWidgets.textFieldInputDecoration(
                              userLastNameController, false, 'Last name', null),
                          CustomWidgets.textFieldInputDecoration(
                              userEmailController, false, 'Email', null),
                          CustomWidgets.textFieldInputDecoration(
                              userPasswordController, false, 'Password', null),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 58,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 45.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: CustomWidgets.gradientDecoration(
                            '#0D7A5C', '#53CD9F'),
                        child: CustomWidgets.buttonStyle(
                            () => onSignup(), 'SIGN IN'),
                      ),
                    ),
                  ]),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onSignup() {
    if (_formKey.currentState!.validate()) {
      debugPrint("Validated");
      userModel.userFirstname = userFirstNameController.text;
      userModel.userLastname = userLastNameController.text;
      userModel.userEmail = userEmailController.text;
      userModel.userPassword = userPasswordController.text;

      UserService().create(userModel).then((value) {
        if (value?.statusCode == 200) {
          const SnackBar(
              duration: Duration(seconds: 5), content: Text('Success'));
          Navigator.pushNamed(context, 'todo');
        } else {
          const SnackBar(content: Text('Something went wrong'));
        }
      });
    }
  }
}