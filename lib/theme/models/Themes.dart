import 'dart:ui';

enum Themes{
  LIGHT(id:1,name: "light"),
  DARK(id:2,name:"dark"),
  ACCESSIBILITY1(id:3,name:"accessibility1"),
  ACCESSIBILITY2(id:4,name: "accessibility2"),
  ACCESSIBILITY3(id:5,name:"accessibility3"),
  NONE(id:-1,name:"none");

  const Themes(
  {
    required this.id,
    required this.name,
      this.backgroundColor = const Color.fromRGBO(255, 255, 255, 1.0),
      this.textColor = const Color.fromRGBO(255, 255, 255, 1.0),
  }
      );

  final int id;
  final String name;
  final Color backgroundColor;
  final Color textColor;

  static Themes fromId(int id){
    return Themes.values.firstWhere((e) => e.id == id, orElse: () => Themes.NONE);
  }

  static Themes fromString(String name){
    return Themes.values.firstWhere((e) => e.name == name, orElse: () => Themes.NONE);
  }
}