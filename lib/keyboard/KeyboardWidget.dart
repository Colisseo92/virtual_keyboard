import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:virtual_keyboard/keyboard/KeyWidget.dart';
import 'package:virtual_keyboard/keyboard/models/BufferedKey.dart';
import 'package:virtual_keyboard/keyboard/services/KeyBuffer.dart';
import 'package:virtual_keyboard/keyboard/models/KeyboardState.dart';
import 'package:virtual_keyboard/keyboard/providers/input_text_provider.dart';
import 'package:virtual_keyboard/keyboard/providers/keyboard_state_provider.dart';
import 'package:virtual_keyboard/keyboard/services/keyboardManager.dart';
import 'package:virtual_keyboard/keyboard/services/layouts/FrenchKeyboard.dart';
import 'package:virtual_keyboard/keyboard/services/layouts/PhoneKeyboardService.dart';
import 'package:virtual_keyboard/keyboard/strategies/french_string_buffer_strategy.dart';

import 'models/KeyObject.dart';

class KeyboardWidget extends ConsumerWidget {

  final KeyboardManager keyboardManager;
  final KeyBuffer buffer;

  KeyboardWidget(
      ref,{
    Key? key,
    required this.keyboardManager,
        required this.buffer,
  }) : super(key: key);

  final double space = 8.0;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    List<List<KeyObject>> keyboardLayout = keyboardManager.keyboardKeyLayout;
    return SafeArea(
      child: Column(
        children: List.generate(
          keyboardLayout.length,
            (row) {
              return Expanded(
                child: SafeArea(
                  child: Row(
                    children: List.generate(
                      keyboardLayout[row].length,
                        (column) {
                          return Expanded(
                            flex: keyboardLayout[row][column].keySize,
                            child: LayoutBuilder(
                              builder: (context, constraints){
                                final keyboardState = ref.watch(keyboardStateProvider);
                                final textOutput = ref.watch(inputTextProvider.notifier);
                                double width = constraints.maxWidth;
                                double height = constraints.maxHeight;
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
                                        BufferedKey bk = BufferedKey(key: keyboardLayout[row][column], capturedState: keyboardState);
                                        PhoneKeyboardService().handleKeyPressed(bk,ref,buffer);
                                      },
                                      child: Text(
                                        keyboardLayout[row][column].getDisplayedCharacter(keyboardState: keyboardState),
                                        style: TextStyle(
                                          fontSize: 40,
                                        ),
                                      ),
                                  ),
                                );
                              },
                            )
                          );
                        }
                    )
                  )
                ),
              );
            }
        ),
      ),
    );
  }
}