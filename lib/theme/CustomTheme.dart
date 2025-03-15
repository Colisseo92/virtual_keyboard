import 'dart:ui';

import 'package:virtual_keyboard/theme/models/Themes.dart';

class CustomTheme{

  final Themes themes;

  const CustomTheme(
  {
    this.themes = Themes.LIGHT,
  }
  );

  Color getBackgroundColor(){
    return themes.backgroundColor;
  }

}