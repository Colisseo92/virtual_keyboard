import 'package:flutter/material.dart';

class App{
  String text;
  bool isShiftPressed = false;

  App(this.text);

  String getText(){
    return this.text;
  }

  static bool isMobile(BuildContext context) =>
      MediaQuery.sizeOf(context).width < 904;

  static bool isTablet(BuildContext context) =>
      MediaQuery.sizeOf(context).width < 1280 && MediaQuery.sizeOf(context).width >= 904;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= 1280;
}