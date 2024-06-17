import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/utilities/colors.dart';
import 'package:todo/utilities/custom_dialog.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late StreamSubscription connectivitySubscription;

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> results) {
      if (results.isNotEmpty && results.last != ConnectivityResult.none) {
        getUserLoggedin().then((value) {
          if (value) {
            Future.delayed(const Duration(seconds: 3), () {
              Navigator.of(context).pushReplacementNamed('todo');
            });
          } else {
            Future.delayed(const Duration(seconds: 3), () {
              Navigator.of(context).pushReplacementNamed('signin');
            });
          }
        });
      } else {
        CustomDialog.errorDialog(context, "No internet connection available.");
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  Future<bool> getUserLoggedin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    return isLoggedIn;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/splash-color.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(image: Svg('assets/images/logo.svg')),
            const SizedBox(
              height: 17.0,
            ),
            CircularProgressIndicator(
              color: AppColors.bgColorItemPrimary,
            ),
          ],
        ),
      ),
    );
  }
}
