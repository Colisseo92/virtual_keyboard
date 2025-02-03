import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:virtual_keyboard/keyboard/models/KeyAction.dart';
import 'package:virtual_keyboard/keyboard/models/KeyObject.dart';
import 'package:virtual_keyboard/keyboard/models/KeyState.dart';
import 'package:virtual_keyboard/keyboard/models/KeyType.dart';
import 'package:virtual_keyboard/keyboard/providers/keyboard_state_provider.dart';
import 'package:virtual_keyboard/utils/StringUtils.dart';

abstract class KeyboardService{
  String handleKeyPressed(KeyObject key, WidgetRef ref){
    print("there");
    final keyboardState = ref.read(keyboardStateProvider.notifier).state;
    print(keyboardState);
    switch(key.keyType){
      case KeyType.special || KeyType.toggle:
        /*
        tab,enter,verr maj,win, space
         */
        if(key.baseCharacter.keyAction == KeyAction.submit){
          return "<enter>";
        }else if(key.baseCharacter.keyAction == KeyAction.toggle){
          toggleCapsLock(ref);
          print(keyboardState);
          return "<capslock>";
        }else if(key.keyOption.hasOption("space")){
          return multiplyString("<space>",key.keyOption.getOption("space"));
        }
        return "";
        break;
      default:
        return key.baseCharacter.character;
        break;
    }
    return "";
  }
}