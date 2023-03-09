import 'package:flutter/material.dart';

getLightThemeApp() {
  return ThemeData(
      primarySwatch: Colors.blue,
      fontFamily: 'Montserrat',
      appBarTheme: const AppBarTheme(
          elevation: 0.5,
          backgroundColor: Colors.white,
          centerTitle: true,
          toolbarTextStyle: TextStyle(color: Colors.black)));
}
