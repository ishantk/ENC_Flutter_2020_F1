import 'package:enc_flutter_2020_f1/tutorials/constants.dart';
import 'package:flutter/material.dart';


// TextTheme i is an object which will have some default data within it :)
TextTheme buildTextTheme(TextTheme textTheme){

  return textTheme.copyWith(
      caption: textTheme.caption.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 14,
          letterSpacing: kLetterSpacing
      ),
      button: textTheme.button.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 16,
          letterSpacing: kLetterSpacing
      )
  ).apply(
      fontFamily: 'Rubik',
      displayColor: kBlueGray900,
      bodyColor: kBlueGray900
  );
}

IconThemeData buildIconTheme(IconThemeData iconThemeData){
  return iconThemeData.copyWith(
      color: kBlueGray900
  );
}

ThemeData buildThemeData(){

  ThemeData themeData = ThemeData.light();

  return themeData.copyWith(
    colorScheme: kColorScheme,
    toggleableActiveColor: kCyan400,
    accentColor: kBlueGray600,
    primaryColorLight: kCyan100,
    buttonColor: kCyan100,
    scaffoldBackgroundColor: kBackgroundWhite,
    cardColor: kBackgroundWhite,
    textSelectionColor: kCyan100,
    errorColor: kError,
    buttonTheme:  ButtonThemeData(
      colorScheme: kColorScheme.copyWith(
        primary: kCyan400
      ),
      textTheme: ButtonTextTheme.normal,
    ),
    primaryIconTheme: buildIconTheme(themeData.primaryIconTheme),
    iconTheme: buildIconTheme(themeData.iconTheme),
    primaryTextTheme: buildTextTheme(themeData.primaryTextTheme),
    accentTextTheme: buildTextTheme(themeData.accentTextTheme),

  );
}