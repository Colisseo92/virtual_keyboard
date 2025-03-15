import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:virtual_keyboard/parameters/models/OptionTextSize.dart';

class ThemeCustomText{

    static const double baseScreenWidth = 300;

    static TextStyle getBasicTextStyle(BuildContext context, OptionTextSize option){
        double screen_width = MediaQuery.of(context).size.width;
        return TextStyle(
          fontSize: 12 * (screen_width/baseScreenWidth) * option.factor,
          color: Colors.black,
        );
    }

    static double getBasicTextSize(BuildContext context, OptionTextSize option){
      double screen_width = MediaQuery.of(context).size.width;
      return 12 * (screen_width/baseScreenWidth) * option.factor;
    }

}