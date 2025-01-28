import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:virtual_keyboard/keyboard/KeyboardManager.dart';

import 'KeyObject.dart';
import 'KeyboardState.dart';

class KeyWidgetButton extends ConsumerWidget {
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

  Widget build(BuildContext context, WidgetRef ref){
    final currentKeyboardState = ref.watch(keyboardStateProvider);
    final currentText = ref.watch(keyboardTextProvider);

    return Container(
      width: this.width,
      height: this.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.black, width: 1),
        color: Colors.white,
        boxShadow: const[
          BoxShadow(
            blurRadius: 30.0,
            offset: Offset(-28,-28),
            color: Colors.white,
          ),
          BoxShadow(
            blurRadius: 30.0,
            offset: Offset(28,28),
            color: Color(0xFFA7A9AF),
          )
        ]
      ),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          ),
          onPressed: (){
            if(this.keyObject.is_holdable){
              if(currentKeyboardState == KeyboardState.normal){
                ref.read(keyboardStateProvider.notifier).state = KeyboardState.shifted;
                this.keyObject.changeHoldState();
              }else{
                ref.read(keyboardStateProvider.notifier).state = KeyboardState.normal;
                this.keyObject.changeHoldState();
              }
            }else{
              ref.read(keyboardTextProvider.notifier).state = currentText + this.keyObject.getKeyDisplayedString();
            }
            this.keyObject.function!();
          },
          child: AutoSizeText(
            currentKeyboardState == KeyboardState.normal ? this.keyObject.primary_text : this.keyObject.shift_text,
            minFontSize: 20,
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
