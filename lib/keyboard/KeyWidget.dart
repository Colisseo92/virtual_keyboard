import 'package:flutter/material.dart';

class KeyWidgetButton extends StatefulWidget {
  final bool state;
  final double width;
  final double height;
  //final KeyLayout key_layout;

  KeyWidgetButton({
    Key? key,
    //required this.key_layout,
    required this.state,
    required this.width,
    required this.height
  }): super(key: key);

  @override
  State<KeyWidgetButton> createState() => _KeyWidgetButtonState();
}

class _KeyWidgetButtonState extends State<KeyWidgetButton>{

  @override
  Widget build(BuildContext context){
    String button_text = widget.state ? "State is true" : "State is False";

    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(15),
      ),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
          ),
          onPressed: (){
            print("pressed");
          },
          child: Text(button_text,style: TextStyle(color: Colors.black),)
      ),
    );
  }
}
