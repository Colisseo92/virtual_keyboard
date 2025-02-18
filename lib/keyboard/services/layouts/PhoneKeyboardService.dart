import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:virtual_keyboard/keyboard/models/BufferedKey.dart';
import 'package:virtual_keyboard/keyboard/models/KeyboardState.dart';
import 'package:virtual_keyboard/keyboard/providers/input_text_provider.dart';
import 'package:virtual_keyboard/keyboard/providers/keyboard_custom_state_provider.dart';
import 'package:virtual_keyboard/keyboard/providers/keyboard_state_provider.dart';
import 'package:virtual_keyboard/keyboard/services/KeyBuffer.dart';
import 'package:virtual_keyboard/keyboard/services/layouts/keyboardService.dart';

class PhoneKeyboardService extends KeyboardService{

  @override
  String handleKeyPressed(BufferedKey buffered_key, WidgetRef ref, KeyBuffer buffer){
    String super_result = super.handleKeyPressed(buffered_key, ref, buffer);
    final keyboardCustomState = ref.watch(keyboardCustomStateProvider.notifier);
    final keyboardState = ref.watch(keyboardStateProvider.notifier);
    if(super_result == "<default>"){ //If the key isn't part of the basic functionnality key
      if(buffered_key.key.keyOption.hasOption("states")){ //if the key cannot have a state
        if(keyboardState.state != KeyboardState.capsLocked){ //If the current keyboardstate is not capsLocked
          changeState(ref, buffered_key.key.keyOption.getOption("states")); //Change the current state of the key
          if(keyboardCustomState.state.description == "shifted"){
            keyboardState.state = KeyboardState.shifted;
          }else if(keyboardCustomState.state.description == "double_shifted"){
            keyboardState.state = KeyboardState.alted;
          }
        }
      }else{
        if(keyboardCustomState.state.description == "shifted"){
          setState(ref,"normal",0,KeyboardState.normal);
        }
        buffer.addKey(buffered_key);
      }
    }else{
      final outputString = ref.watch(inputTextProvider.notifier);
      if(super_result == "<delete>"){
        outputString.state = outputString.state.isNotEmpty ? outputString.state.substring(0,outputString.state.length-1) : outputString.state;
      }else{
        outputString.state += super_result;
      }
    }
    return super_result;
  }

}