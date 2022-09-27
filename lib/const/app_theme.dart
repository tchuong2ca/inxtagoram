
import 'package:inxtagoram/const/app_dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inxtagoram/const/colors.dart';

import 'colors.dart';

//Done use this. To get current theme: use Theme.of(context)
class AppTheme {
  static const Color _mainColor = AppColors.primary;
  static const Color _soft = Color(0xFFF9F9F9);
  static const Color outlineColor = Color(0xFFD6D8DE);

  static const TextTheme defaultTextTheme = TextTheme(
    headline1: TextStyle(fontSize: 96, fontWeight: FontWeight.w300, color: AppColors.black),
    headline2: TextStyle(fontSize: 60, fontWeight: FontWeight.w300, color: AppColors.black),
    headline3: TextStyle(fontSize: 48, fontWeight: FontWeight.normal, color: AppColors.black),
    headline4: TextStyle(fontSize: 34, fontWeight: FontWeight.normal, color: AppColors.black),
    headline5: TextStyle(fontSize: 24, fontWeight: FontWeight.normal, color: AppColors.black),
    headline6: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.black),
    subtitle1: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: AppColors.black),
    subtitle2: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.black),
    bodyText1: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.black),
    bodyText2: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: AppColors.black),
    button: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.black),
    caption: TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: AppColors.black),
    overline: TextStyle(fontSize: 10, fontWeight: FontWeight.normal, color: AppColors.black),
  );

  static final ThemeData appTheme = ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    indicatorColor: _mainColor,
    splashColor: _mainColor,
    hoverColor: _mainColor,
    backgroundColor: AppColors.background,
    scaffoldBackgroundColor: AppColors.background,
    cardTheme: const CardTheme(elevation: 2, color: Colors.white, clipBehavior: Clip.hardEdge, shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8)))),
    dialogTheme: const DialogTheme(elevation: 3, backgroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8)))),

    cardColor: Colors.white,
    textTheme: defaultTextTheme,
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
    ),
    buttonTheme: const ButtonThemeData(
        textTheme: ButtonTextTheme.primary,
        buttonColor: _mainColor,
        height: AppDimens.buttonHeight,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8)), side: BorderSide(style: BorderStyle.none))),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      elevation: 16.0,
      showUnselectedLabels: true,
      selectedItemColor: _mainColor,
    ), colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepOrange).copyWith(secondary: _mainColor),
  );

  static final AppBarTheme lightAppbarTheme = AppBarTheme(
    elevation: 2,
    color: Colors.white,
    iconTheme: const IconThemeData(color: AppColors.primary),
    actionsIconTheme: const IconThemeData(color: AppColors.primary), systemOverlayStyle: SystemUiOverlayStyle.dark, toolbarTextStyle: appTheme.textTheme.bodyText2, titleTextStyle: appTheme.textTheme.headline6,
  );

  static InputDecoration getTextInputDecoration(String? labelText, String? errorText, String? hintText) {
    InputDecoration decoration = InputDecoration(
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.primary, width: 1.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.gray, width: 1.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      labelText: labelText,
    );

    decoration = decoration.copyWith(errorText: errorText);
    decoration = decoration.copyWith(hintText: hintText);
    return decoration;
  }

  static InputDecoration textFieldInputDecoration(IconData? iconData, String labelText, String? errorText, String hintText) {
    InputDecoration decoration = InputDecoration(
        border: const OutlineInputBorder(borderSide: BorderSide(color: AppColors.primary)),
        hintText: hintText,
        // helperText: errorText,
        errorText: errorText,
        labelText: labelText,
        prefixIcon: Icon(
          iconData,
          color: AppColors.primary,
        ),
        prefixText: '',
        suffixText: '',
        suffixStyle: const TextStyle(color: AppColors.error));

    // decoration = decoration.copyWith(errorText: errorText);
    // decoration = decoration.copyWith(hintText: hintText);
    return decoration;
  }
  static InputDecoration textFieldInputDecoration2(String labelText, String? errorText, String hintText) {
    InputDecoration decoration = InputDecoration(
        border: const OutlineInputBorder(borderSide: BorderSide(color: AppColors.primary)),
        hintText: hintText,
        // helperText: errorText,
        errorText: errorText,
        labelText: labelText,
        prefixText: '',
        suffixText: '',
        alignLabelWithHint: true,
        suffixStyle: const TextStyle(color: AppColors.error));
    return decoration;
  }

  static InputDecoration textFieldInputContact(String labelText, String? errorText, String hintText) {
    InputDecoration decoration = InputDecoration(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 16,horizontal: 16),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.lightGrey),
          borderRadius: BorderRadius.all(Radius.circular(25)),
        ),
        hintText: hintText,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.lightGrey),
          borderRadius: BorderRadius.all(Radius.circular(25)),
        ),
        errorText: errorText,
        labelText: labelText,
        prefixText: '',
        suffixText: '',
        suffixStyle: const TextStyle(color: AppColors.black));
    return decoration;
  }

  static InputDecoration textFieldContact(String labelText, String? errorText, String hintText) {
    InputDecoration decoration = InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 16,horizontal: 16),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.lightGrey),
          borderRadius: BorderRadius.all(Radius.circular(25)),
        ),
        hintText: hintText,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.lightGrey),
          borderRadius: BorderRadius.all(Radius.circular(25)),
        ),
        errorText: errorText,
        labelText: labelText,
        filled: true,
        fillColor: Colors.white,
        prefixText: '',
        suffixText: '',
        suffixStyle: const TextStyle(color: AppColors.black));
    return decoration;
  }

  static InputDecoration textFieldPass({required String hintText,String? passError,Widget? suffixIcon}) {
    InputDecoration decoration = InputDecoration(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 16,horizontal: 16),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.lightGrey),
          borderRadius: BorderRadius.all(Radius.circular(25)),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.lightGrey),
          borderRadius: BorderRadius.all(Radius.circular(25)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primary,width: 2),
          borderRadius: BorderRadius.all(Radius.circular(25)),),
        hintText: hintText,
        errorText: passError,
        prefixIcon: const Icon(
          Icons.lock,
          color: AppColors.primary,
        ),
        suffixIcon: suffixIcon,
        suffixStyle: const TextStyle(color: AppColors.error));
    return decoration;
  }

  static TextStyle textStyleLexendLight({required double? fontSize,Color? color,bool? overFlow}){
    return TextStyle(
        color: color ?? AppColors.black,
        fontFamily: 'LexendLight',
        fontSize: fontSize,
        overflow: overFlow == true ? TextOverflow.ellipsis : TextOverflow.visible
    );
  }

  static TextStyle textStyleLexendThin({required double? fontSize,Color? color}){
    return TextStyle(
        color: color ?? AppColors.black,
        fontFamily: 'LexendLight',
        fontSize: fontSize ?? 13
    );
  }

  static TextStyle textStyleLexendBold({required double? fontSize,Color? color,bool? overFlow}){
    return TextStyle(
      color: color ?? AppColors.black,
      fontFamily: 'LexendBold',
      fontSize: fontSize ?? 13,
      overflow: overFlow == true ? TextOverflow.ellipsis : TextOverflow.visible,
    );
  }

  static TextStyle textStyleLexendRegular({required double? fontSize,Color? color,bool? overFlow}){
    return TextStyle(
        color: color ?? AppColors.black,
        fontFamily: 'LexendRegular',
        fontSize: fontSize ?? 13,
        overflow: overFlow == true ? TextOverflow.ellipsis : TextOverflow.visible
    );
  }
  static TextStyle textStyleNormal({required double? fontSize,Color? color}){
    return TextStyle(
        color: color ?? AppColors.black,
        fontSize: fontSize ?? 13
    );
  }
  static TextStyle textStyleLexendMedium({required double? fontSize,Color? color,bool? overFlow}){
    return TextStyle(
        color: color ?? AppColors.black,
        fontFamily: 'LexendMedium',
        fontSize: fontSize ?? 13,
        overflow: overFlow == true ? TextOverflow.ellipsis : TextOverflow.visible
    );
  }

}
