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
                                  color: keyboardLayout[row][column].baseCharacter.keyAction.debugColor,
                                  width: width,
                                  height: height,
                                  child: Center(
                                    child: ElevatedButton(
                                        onPressed: (){
                                          BufferedKey bk = BufferedKey(key: keyboardLayout[row][column], capturedState: keyboardState);
                                          FrenchKeyboard().handleKeyPressed(bk,ref,buffer);
                                        },
                                        child: Text(
                                          keyboardLayout[row][column].getDisplayedCharacter(keyboardState: keyboardState),
                                          style: TextStyle(
                                            fontSize: 20,
                                          ),
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