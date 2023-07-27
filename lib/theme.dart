import 'package:flutter/material.dart';

import 'constants.dart';

ThemeData lightThemeData(BuildContext context){
  return ThemeData.light().copyWith(
    scaffoldBackgroundColor: lightBackgroundColor,
    iconTheme: const IconThemeData(color: purple),
    primaryIconTheme: const IconThemeData(color: purple),
    appBarTheme: const AppBarTheme(backgroundColor: lightBackgroundColor,elevation: 0,actionsIconTheme: IconThemeData(color: purple),centerTitle: true, 
    titleTextStyle: TextStyle(color: purple,fontSize: 25)),
    elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom(backgroundColor: purple,)),
  
  );
}

ThemeData darkThemeData(BuildContext context){
  return ThemeData.dark().copyWith(
    scaffoldBackgroundColor: darkBackgroundColor,
    iconTheme: const IconThemeData(color: lightBackgroundColor),
    appBarTheme: const AppBarTheme(backgroundColor: darkBackgroundColor, elevation: 0,actionsIconTheme: IconThemeData(color: lightBackgroundColor),centerTitle: true),
    elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom(backgroundColor: purple,)),

  );
}


bool isDark(BuildContext context){
  final Brightness brightness = MediaQuery.of(context).platformBrightness;
    return brightness == Brightness.dark;
}