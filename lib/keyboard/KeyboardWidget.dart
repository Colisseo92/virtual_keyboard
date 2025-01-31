import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:virtual_keyboard/keyboard/KeyWidget.dart';
import 'package:virtual_keyboard/keyboard/services/keyboardManager.dart';

import 'models/KeyObject.dart';

class KeyboardWidget extends ConsumerWidget {

  final KeyboardManager keyboardManager;

  KeyboardWidget({
    Key? key,
    required this.keyboardManager,
  }) : super(key: key);

  final double space = 8.0;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    List<List<KeyObject>> keyboardLayout = keyboardManager.keyboardKeyLayout;

    print(keyboardLayout);
    return SafeArea(
      child: Column(
        children: List.generate(
          keyboardLayout.length,
            (row) {
            print("Building row $row");
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
                                double width = constraints.maxWidth;
                                double height = constraints.maxHeight;
                                return Container(
                                  color: keyboardLayout[row][column].baseCharacter.keyAction.debugColor,
                                  width: width,
                                  height: height,
                                  child: Center(
                                    child: Text(
                                      keyboardLayout[row][column].baseCharacter.character,
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

