import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:virtual_keyboard/keyboard/models/BufferedKey.dart';
import 'package:virtual_keyboard/keyboard/providers/input_text_provider.dart';
import 'package:virtual_keyboard/keyboard/providers/keyboard_custom_state_provider.dart';
import 'package:virtual_keyboard/keyboard/providers/keyboard_state_provider.dart';
import 'package:virtual_keyboard/keyboard/services/KeyBuffer.dart';
import 'package:virtual_keyboard/keyboard/services/layouts/PhoneKeyboardService.dart';
import 'package:virtual_keyboard/parameters/models/OptionTextSize.dart';
import 'package:virtual_keyboard/parameters/providers/parameter_provider.dart';
import 'package:virtual_keyboard/theme/models/Themes.dart';
import 'package:virtual_keyboard/theme/styles/ThemeCustomText.dart';

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
    return Consumer(builder: (context,ref,child){
      final param_provider = ref.watch(parameter_provider);
      return param_provider.when(
        error: (error,stack) => Text("Error: $error"),
        loading: (){
          return CircularProgressIndicator();
        },
        data: (parameter){
          final keyboardState = ref.watch(keyboardStateProvider);
          OptionTextSize optionTextSize = OptionTextSize.fromString(parameter.getParameter("policeSize").value);
          Themes currentTheme = Themes.fromString(parameter.getParameter("theme").value);
          return Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: currentTheme.keyColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: currentTheme.shadowColor,
                  offset: Offset(-1, -1),
                  blurRadius: 10,
                ),
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.2),
                  offset: Offset(-1,-1),
                  blurRadius: 10,
                )
              ],
            ),
            margin: EdgeInsets.all(5),
            child: MaterialButton(
              hoverColor: Colors.purple,
              splashColor: Colors.transparent,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              onPressed: (){
                BufferedKey bk = BufferedKey(key: this.keyObject, capturedState: keyboardState);
                PhoneKeyboardService().handleKeyPressed(bk,ref,this.buffer);
              },
              child: Text(
                this.keyObject.getDisplayedCharacter(keyboardState: keyboardState),
                style: TextStyle(
                  fontSize: ThemeCustomText.getBasicTextSize(context, optionTextSize),
                  color: currentTheme.textColor,
                ),
              ),
            ),
          );
        },
      );
    });
  }
}
