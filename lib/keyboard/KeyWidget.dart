import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:virtual_keyboard/keyboard/models/BufferedKey.dart';
import 'package:virtual_keyboard/keyboard/providers/input_text_provider.dart';
import 'package:virtual_keyboard/keyboard/providers/keyboard_state_provider.dart';
import 'package:virtual_keyboard/keyboard/services/KeyBuffer.dart';
import 'package:virtual_keyboard/keyboard/services/layouts/PhoneKeyboardService.dart';

import 'models/KeyObject.dart';
import 'models/KeyboardState.dart';

class KeyWidgetButton extends ConsumerWidget {
  final KeyObject keyObject;
  final double width;
  final double height;
  final KeyBuffer buffer;

  KeyWidgetButton({
    Key? key,
    required this.keyObject,
    required this.width,
    required this.height,
    required this.buffer,
  }) : super(key: key);

  Widget build(BuildContext context, WidgetRef ref) {
    final keyboardState = ref.watch(keyboardStateProvider);

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(255, 255, 255, 0.7),
              offset: Offset(-5, -5),
              blurRadius: 10,
            ),
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.2),
              offset: Offset(-5,-5),
              blurRadius: 10,
            )
          ],
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors:[
                Color.fromRGBO(224, 224, 224, 1.0),
                Color.fromRGBO(214, 214, 214, 1.0),
              ]
          )
      ),
      margin: EdgeInsets.all(5),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shadowColor: Colors.transparent,
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        onPressed: (){
          BufferedKey bk = BufferedKey(key: this.keyObject, capturedState: keyboardState);
          PhoneKeyboardService().handleKeyPressed(bk,ref,this.buffer);
        },
        child: Text(
          this.keyObject.getDisplayedCharacter(keyboardState: keyboardState),
          style: TextStyle(
            fontSize: 40,
          ),
        ),
      ),
    );
  }
}
