import 'package:virtual_keyboard/keyboard/KeyObject.dart';
import 'package:virtual_keyboard/keyboard/KeyboardState.dart';

class Keyboard{

  KeyboardState state;

  int keyboard_width_size;
  int keyboard_height_size;

  List<List<KeyObject>> keyboard_key_layout = [];

  Keyboard(
      this.keyboard_width_size,
      this.keyboard_height_size,{
        this.state = KeyboardState.normal,
      }
      ){
    List<KeyObject> first_line = [
      KeyObject("²","",1,this.state),
      KeyObject("&","",1,this.state),
      KeyObject("é","",1,this.state),
      KeyObject("\"","",1,this.state),
      KeyObject("'","",1,this.state),
      KeyObject("(","",1,this.state),
      KeyObject("-","",1,this.state),
      KeyObject("è","",1,this.state),
      KeyObject("_","",1,this.state),
      KeyObject("ç","",1,this.state),
      KeyObject("à","",1,this.state),
      KeyObject(")","",1,this.state),
      KeyObject("=","",1,this.state),
      KeyObject("<del>","",2,this.state),
    ];

    List<KeyObject> second_line = [
      KeyObject("<tab>","",2,this.state),
      KeyObject("a","",1,this.state),
      KeyObject("z","",1,this.state),
      KeyObject("e","",1,this.state),
      KeyObject("r","",1,this.state),
      KeyObject("t","",1,this.state),
      KeyObject("y","",1,this.state),
      KeyObject("u","",1,this.state),
      KeyObject("i","",1,this.state),
      KeyObject("o","",1,this.state),
      KeyObject("p","",1,this.state),
      KeyObject("^","",1,this.state),
      KeyObject("\$","",1,this.state),
      KeyObject("<enter>","",1,this.state),
    ];

    List<KeyObject> third_line = [
      KeyObject("<maj>","",2,this.state),
      KeyObject("q","",1,this.state),
      KeyObject("s","",1,this.state),
      KeyObject("d","",1,this.state),
      KeyObject("f","",1,this.state),
      KeyObject("g","",1,this.state),
      KeyObject("h","",1,this.state),
      KeyObject("j","",1,this.state),
      KeyObject("k","",1,this.state),
      KeyObject("l","",1,this.state),
      KeyObject("m","",1,this.state),
      KeyObject("ù","",1,this.state),
      KeyObject("*","",1,this.state),
      KeyObject("<enter>","",1,this.state),
    ];

    List<KeyObject> fourth_line = [
      KeyObject("<shift>","",1,this.state),
      KeyObject("<","",1,this.state),
      KeyObject("w","",1,this.state),
      KeyObject("x","",1,this.state),
      KeyObject("c","",1,this.state),
      KeyObject("v","",1,this.state),
      KeyObject("b","",1,this.state),
      KeyObject("n","",1,this.state),
      KeyObject(",","",1,this.state),
      KeyObject(";","",1,this.state),
      KeyObject(":","",1,this.state),
      KeyObject("!","",1,this.state),
      KeyObject("<shift>","",2,this.state,is_holdable: true),
    ];

    List<KeyObject> fifth_line = [
      KeyObject("<r-ctrl>","",1,this.state),
      KeyObject("<win>","",1,this.state),
      KeyObject("<alt>","",1,this.state),
      KeyObject("<space>","",7,this.state),
      KeyObject("alt gr","",1,this.state),
      KeyObject("<fn>","",1,this.state),
      KeyObject("<btn>","",1,this.state),
      KeyObject("<r-ctrl>","",1,this.state),
    ];


    this.keyboard_key_layout = [
      first_line,
      second_line,
      third_line,
      fourth_line,
      fifth_line,
    ];
  }

}