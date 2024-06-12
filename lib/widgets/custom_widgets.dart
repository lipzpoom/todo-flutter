import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:todo/utilities/colors.dart';

class CustomWidgets {
  static textFieldInputDecoration(
    TextEditingController? textController,
    bool password,
    String labelText,
    String? hintText,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: HexColor('#F3F3F3'),
        borderRadius: const BorderRadius.all(Radius.circular(15.0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 1,
            offset: const Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: TextFormField(
        controller: textController,
        obscureText: password,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter your ${labelText.toLowerCase()}';
          }
          return null;
        },
        decoration: InputDecoration(
          fillColor: HexColor('#F3F3F3'),
          filled: true,
          labelStyle: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
            color: HexColor('#666161'),
          ),
          labelText: labelText,
          // hintText: hintText ?? labelText,
          hintStyle: const TextStyle(fontSize: 12),
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
              borderSide: BorderSide.none),
        ),
      ),
    );
  }

  static BoxDecoration inputDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.25),
          blurRadius: 6,
        ),
      ],
    );
  }

  static BoxDecoration gradientDecoration(String color1, String color2) {
    return BoxDecoration(
      borderRadius: const BorderRadius.all(Radius.circular(15.0)),
      gradient: LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        colors: [
          HexColor(color1),
          HexColor(color2),
        ],
      ),
    );
  }

  static buttonStyle(Function()? function, String labelText) {
    return ElevatedButton(
        onPressed: function,
        style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          elevation: 0,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 23),
          child: Text(
            labelText,
            style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w400,
                color: AppColors.textForeground),
          ),
        ));
  }

  static buttonMenu(Function()? function, String iconPath, String menuName) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: InkWell(
        onTap: function,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        hoverColor: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image(image: Svg(iconPath, scale: 24)),
                const SizedBox(width: 9.0),
                Text(
                  menuName,
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                      color: HexColor('#0D7A5C')),
                )
              ],
            ),
            const Image(image: Svg('assets/images/arrowright.svg', scale: 24))
          ],
        ),
      ),
    );
  }
}
