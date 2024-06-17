import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:todo/utilities/colors.dart';

class CustomDialog {
  static warningDialog(BuildContext context, String title, String? desc,
      Function()? function) async {
    return await AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      animType: AnimType.scale,
      title: title,
      desc: desc,
      btnCancelOnPress: () {},
      btnOkOnPress: function,
      btnCancelColor: Colors.red[200],
      btnOkColor: AppColors.bgColorItemPrimary,
    ).show();
  }

  static questionDialog(
      BuildContext context, String? title, Function()? function) async {
    return await AwesomeDialog(
      context: context,
      dialogType: DialogType.question,
      animType: AnimType.scale,
      title: title,
      btnCancelOnPress: () {},
      btnOkOnPress: function,
      btnCancelColor: Colors.red[300],
      btnOkColor: AppColors.bgColorItemPrimary,
    ).show();
  }

  static errorDialog(BuildContext context, String? desc) async {
    return await AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.scale,
      title: "Error!",
      desc: desc,
      btnCancelColor: Colors.red[200],
      btnOkColor: AppColors.bgColorItemPrimary,
    ).show();
  }

  static loadingDialog(BuildContext context) async {
    return await AwesomeDialog(
      context: context,
      dialogType: DialogType.noHeader,
      animType: AnimType.scale,
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              valueColor:
                  AlwaysStoppedAnimation<Color>(AppColors.bgColorItemPrimary),
            ),
            const SizedBox(
              height: 8.0,
            ),
            const Text('Loading...')
          ],
        ),
      ),
    ).show();
  }
}
