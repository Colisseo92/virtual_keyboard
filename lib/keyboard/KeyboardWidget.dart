import 'package:flutter/cupertino.dart';
import 'package:virtual_keyboard/keyboard/KeyWidget.dart';
import 'package:virtual_keyboard/keyboard/Keyboard.dart';

import 'KeyObject.dart';

class KeyboardWidget extends StatefulWidget {
  bool state;
  Keyboard keyboard;
  
  KeyboardWidget({
    Key? key,
    //required this.key_layout,
    required this.state,
    required this.keyboard,
  }): super(key: key);

  @override
  State<KeyboardWidget> createState() => _KeyboardWidgetState();
}

class _KeyboardWidgetState extends State<KeyboardWidget> {
  final int space = 8;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints){
          double width = (constraints.maxWidth - (widget.keyboard.keyboard_width_size-1)*space)/widget.keyboard.keyboard_width_size;
          double height = (constraints.maxHeight - (widget.keyboard.keyboard_height_size-1)*space)/widget.keyboard.keyboard_height_size;
          return Column(
            spacing: 8,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              widget.keyboard.keyboard_height_size,
                (line) => Row(
                  spacing: 8,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                  widget.keyboard.keyboard_width_size-1,
                      (key){
                        if(line < widget.keyboard.keyboard_key_layout.length){
                          if(key < widget.keyboard.keyboard_key_layout[line].length){
                            KeyObject keyObject = widget.keyboard.keyboard_key_layout[line][key];
                            return KeyWidgetButton(state: widget.state, width: width*keyObject.key_size+(keyObject.key_size-1)*space, height: height, keyObject: keyObject);
                          }else{
                            return SizedBox.shrink();
                          }
                        }else{
                          return SizedBox.shrink();
                        }
                      }
                  ),
                )
            )
          );
        }
    );
  }
}

