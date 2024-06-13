import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:todo/services/auth.service.dart';
import 'package:todo/utilities/custom_dialog.dart';
import 'package:todo/utilities/colors.dart';
import 'package:todo/widgets/custom_widgets.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _userEmailController = TextEditingController();
  final TextEditingController _userPasswordController = TextEditingController();

  bool showPassword = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _userEmailController.dispose();
    _userPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        CustomDialog.warningDialog(
            context, 'Close the app?', () => SystemNavigator.pop());
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Form(
          key: _formKey,
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SafeArea(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/background.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                padding: const EdgeInsets.only(
                    top: 60.0, bottom: 8.0, right: 8.0, left: 8.0),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(children: [
                          Text(
                            "SIGN IN",
                            style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w500,
                                color: AppColors.textPrimary),
                          ),
                          const SizedBox(
                            height: 19.0,
                          ),
                          Text(
                            textAlign: TextAlign.center,
                            "Please enter the information \n below to access.",
                            style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w400,
                                color: AppColors.textPrimary),
                          ),
                          const SizedBox(height: 35.0),
                          const Image(image: Svg("assets/images/signin.svg")),
                          const SizedBox(height: 35.0),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 45),
                            child: Wrap(
                              runSpacing: 20.0,
                              children: [
                                CustomWidgets.textFieldInputDecoration(
                                    _userEmailController, false, 'Email', null),
                                const SizedBox(height: 10.0),
                                CustomWidgets.textFieldInputDecoration(
                                    _userPasswordController,
                                    showPassword,
                                    'Password',
                                    null),
                                const Align(
                                    alignment: Alignment.topRight,
                                    child: Text(
                                      "Forgot Password?",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400),
                                    )),
                              ],
                            ),
                          ),
                          // const SizedBox(
                          //   height: 76,
                          // ),
                          // const Spacer(),
                        ]),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 45.0),
                      child: Wrap(runSpacing: 20, children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: CustomWidgets.gradientDecoration(
                              '#0D7A5C', '#53CD9F'),
                          child: CustomWidgets.buttonStyle(() {
                            onSignin();
                          }, 'SIGN IN'),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: CustomWidgets.gradientDecoration(
                              '#00503E', '#0D7A5C'),
                          child: CustomWidgets.buttonStyle(() {
                            Navigator.pushNamed(context, 'signup');
                          }, 'SIGN UP'),
                        ),
                      ]),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onSignin() async {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      await AuthServices()
          .signin(_userEmailController.text, _userPasswordController.text)
          .then((value) => Navigator.pushNamed(context, 'todo'));
    }
  }
}
