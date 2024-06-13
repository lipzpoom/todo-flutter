import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:todo/utilities/colors.dart';

class CustomDialog {
  static warningDialog(
      BuildContext context, String title, Function()? function) async {
    return await AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      animType: AnimType.scale,
      title: title,
      // desc: 'Dialog description here.............',
      btnCancelOnPress: () {},
      btnOkOnPress: function,
      btnCancelColor: Colors.red[200],
      btnOkColor: AppColors.bgColorItemPrimary,
    ).show();
  }
}
