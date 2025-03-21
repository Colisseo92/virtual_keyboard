import 'dart:ui';

enum Themes{
  LIGHT(id:1,name: "light",
    backgroundColor: Color.fromRGBO(236, 240, 241,1.0),
    keyColor: Color.fromRGBO(236, 240, 241,1.0),
    textColor: Color.fromRGBO(44, 62, 80,1.0),
  ),
  DARK(id:2,name:"dark",
    backgroundColor: Color.fromRGBO(44, 62, 80,1.0),
    keyColor: Color.fromRGBO(52, 73, 94,1.0),
    textColor: Color.fromRGBO(236, 240, 241,1.0)),
  ACCESSIBILITY1(id:3,name:"contrast",
    backgroundColor: Color.fromRGBO(241, 196, 15,1.0),
    keyColor: Color.fromRGBO(241, 196, 15,1.0),
      textColor: Color.fromRGBO(0,0,0,1.0),
  ),
  NONE(id:-1,name:"none");

  const Themes(
  {
    required this.id,
    required this.name,
      this.backgroundColor = const Color.fromRGBO(255, 255, 255, 1.0),
      this.textColor = const Color.fromRGBO(255, 255, 255, 1.0),
    this.keyColor = const Color.fromRGBO(255, 255, 255, 1.0),
  }
      );

  final int id;
  final String name;
  final Color backgroundColor;
  final Color textColor;
  final Color keyColor;

  static Themes fromId(int id){
    return Themes.values.firstWhere((e) => e.id == id, orElse: () => Themes.NONE);
  }

  static Themes fromString(String name){
    return Themes.values.firstWhere((e) => e.name == name, orElse: () => Themes.NONE);
  }
}