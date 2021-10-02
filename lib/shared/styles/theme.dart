

import 'package:flutter/material.dart';
import 'package:news_application/shared/components/constants.dart';
import 'package:news_application/shared/styles/styles.dart';

import 'colors.dart';

ThemeData theme= ThemeData(
    fontFamily: "Cairo",
    primaryColor: primaryColorLight,
    backgroundColor: backgroundColorLight,
    dividerColor: reverseColorLight,
    indicatorColor: backgroundColorLight,
    cardColor: reverseColorLight,
    colorScheme: ColorScheme.light(),
    iconTheme: IconThemeData(color: reverseColorLight),
    popupMenuTheme: PopupMenuThemeData(
      color: backgroundColorLight,
    ),
    inputDecorationTheme: InputDecorationTheme(
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: secondaryColorLight))),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(primaryColorLight),
          overlayColor: MaterialStateProperty.all(backgroundColorLight)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius))),
          backgroundColor: MaterialStateProperty.all(backgroundColorLight)),
    ),
    tabBarTheme: TabBarTheme(
      labelColor: reverseColorLight,
      unselectedLabelColor: secondaryColorLight,
      labelStyle: textStyle(fontSize: 15, color: reverseColorLight),
      unselectedLabelStyle: textStyle(fontSize: 13, color: secondaryColorLight),
    ),
    appBarTheme: AppBarTheme(
      color: backgroundColorLight,
      titleTextStyle: textStyle(color: reverseColorLight, fontSize: 16),
      iconTheme: IconThemeData(color: reverseColorLight),
    ),
    checkboxTheme: CheckboxThemeData(
      checkColor: MaterialStateProperty.all(primaryColorLight),
      fillColor: MaterialStateProperty.all(reverseColorLight),
    ),
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.all(reverseColorLight),
    ),
    textTheme: TextTheme(
        headline1: textStyle(fontSize: 16, color: reverseColorLight),
        headline2: textStyle(fontSize: 15, color: reverseColorLight),
        headline3: textStyle(fontSize: 14, color: reverseColorLight),
        headline4: textStyle(fontSize: 13, color: reverseColorLight),
        headline5: textStyle(
            fontSize: 12,
            color: reverseColorLight,
            fontWeight: FontWeight.normal),
        headline6: textStyle(fontSize: 11, color: reverseColorLight),
        bodyText1: textStyle(fontSize: 15, color: backgroundColorLight),
        bodyText2: textStyle(fontSize: 14, color: backgroundColorLight),
        subtitle1: textStyle(
            fontSize: 13,
            color: secondaryColorLight,
            fontWeight: FontWeight.normal),
        button: textStyle(
            fontSize: 13,
            color: primaryColorLight,
            fontWeight: FontWeight.bold),
        caption: textStyle(
            fontSize: 14,
            color: reverseColorLight,
            fontWeight: FontWeight.normal),
        overline: textStyle(
            color: Colors.blue, fontSize: 14, fontWeight: FontWeight.bold)),
    textSelectionTheme: TextSelectionThemeData(
        selectionHandleColor: Colors.blue.withOpacity(0.5),
        cursorColor: Colors.blue.withOpacity(0.5),selectionColor: Colors.blue.withOpacity(0.5)));
ThemeData darkTheme= ThemeData(
    fontFamily: "Cairo",
    primaryColor: primaryColorDark,
    backgroundColor: backgroundColorDark,
    dividerColor: reverseColorDark,
    indicatorColor: backgroundColorDark,
    cardColor: reverseColorDark,
    canvasColor: mainColorDark,
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.white),
    iconTheme: IconThemeData(color: reverseColorDark),
    popupMenuTheme: PopupMenuThemeData(
      color: backgroundColorDark,
    ),
    inputDecorationTheme: InputDecorationTheme(
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: secondaryColorDark))),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0))),
          backgroundColor: MaterialStateProperty.all(primaryColorDark),
          overlayColor: MaterialStateProperty.all(backgroundColorDark)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius))),
          backgroundColor:
          MaterialStateProperty.all(backgroundColorDark)),
    ),
    tabBarTheme: TabBarTheme(
      labelColor: reverseColorDark,
      unselectedLabelColor: secondaryColorDark,
      labelStyle: textStyle(fontSize: 15, color: reverseColorDark),
      unselectedLabelStyle:
      textStyle(fontSize: 13, color: secondaryColorDark),
    ),
    appBarTheme: AppBarTheme(
      color: backgroundColorDark,
      titleTextStyle: textStyle(color: reverseColorDark, fontSize: 16),
      iconTheme: IconThemeData(color: reverseColorDark),
    ),
    checkboxTheme: CheckboxThemeData(
      checkColor: MaterialStateProperty.all(primaryColorDark),
      fillColor: MaterialStateProperty.all(reverseColorDark),
    ),
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.all(reverseColorDark),
    ),
    textTheme: TextTheme(
        headline1: textStyle(fontSize: 16, color: reverseColorDark),
        headline2: textStyle(fontSize: 15, color: reverseColorDark),
        headline3: textStyle(fontSize: 14, color: reverseColorDark),
        headline4: textStyle(fontSize: 13, color: reverseColorDark),
        headline5: textStyle(
            fontSize: 12,
            color: reverseColorDark,
            fontWeight: FontWeight.normal),
        headline6: textStyle(fontSize: 11, color: reverseColorDark),
        bodyText1: textStyle(fontSize: 15, color: backgroundColorDark),
        bodyText2: textStyle(fontSize: 14, color: backgroundColorDark),
        subtitle1: textStyle(
            fontSize: 13,
            color: secondaryColorDark,
            fontWeight: FontWeight.normal),
        button: textStyle(
            fontSize: 13,
            color: primaryColorDark,
            fontWeight: FontWeight.bold),
        caption: textStyle(
            fontSize: 14,
            color: reverseColorDark,
            fontWeight: FontWeight.normal),
        overline: textStyle(
            color: Colors.blue,
            fontSize: 14,
            fontWeight: FontWeight.bold)),
    textSelectionTheme: TextSelectionThemeData(
        selectionHandleColor: Colors.blue.withOpacity(0.5),
        cursorColor: Colors.blue.withOpacity(0.5),selectionColor: Colors.blue.withOpacity(0.5))
);
