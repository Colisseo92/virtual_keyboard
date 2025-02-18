import 'dart:ui';

enum Themes{
  ACCESSIBLE(
    backgroundColor: Color.fromRGBO(255, 255, 255, 1.0),
  ),
  NORMAL(
    backgroundColor: Color.fromRGBO(224, 224, 224, 1.0),
    textColor: Color.fromRGBO(255, 255, 255, 1.0),
  );

  const Themes(
  {
      this.backgroundColor = const Color.fromRGBO(255, 255, 255, 1.0),
      this.textColor = const Color.fromRGBO(255, 255, 255, 1.0),
  }
      );

  final Color backgroundColor;
  final Color textColor;
}