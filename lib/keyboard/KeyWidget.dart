import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'KeyObject.dart';

class KeyWidgetButton extends StatefulWidget {
  final bool state;
  final double width;
  final double height;
  final KeyObject keyObject;

  KeyWidgetButton({
    Key? key,
    //required this.key_layout,
    required this.state,
    required this.width,
    required this.height,
    required this.keyObject,
  }): super(key: key);

  @override
  State<KeyWidgetButton> createState() => _KeyWidgetButtonState();
}

class _KeyWidgetButtonState extends State<KeyWidgetButton>{

  @override
  Widget build(BuildContext context){

    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: widget.keyObject.is_hold ? Colors.purple : Colors.blue,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          ),
          onPressed: (){
            if(widget.keyObject.is_holdable){
              setState(() {
                widget.keyObject.changeHoldState();
              });
            }
            widget.keyObject.function!();
          },
          child: AutoSizeText(
            widget.keyObject.getKeyDisplayedString(),
            minFontSize: 12,
            maxFontSize: 50,
            style: TextStyle(
              color: Colors.black,
              fontStyle: FontStyle.normal,
            ),
          )
      ),
    );
  }
}
