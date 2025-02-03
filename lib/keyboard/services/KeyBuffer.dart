import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:virtual_keyboard/keyboard/models/BufferedKey.dart';
import 'package:virtual_keyboard/keyboard/models/KeyCombinationResult.dart';
import 'package:virtual_keyboard/keyboard/models/KeyboardState.dart';
import 'package:virtual_keyboard/keyboard/providers/input_text_provider.dart';
import 'package:virtual_keyboard/keyboard/providers/keyboard_state_provider.dart';
import 'package:virtual_keyboard/keyboard/strategies/string_buffer_strategy.dart';

import '../models/KeyObject.dart';

class KeyBuffer{

  final List<BufferedKey> _buffer = [];
  StringBufferStrategy strategy;
  WidgetRef ref;

  KeyBuffer(
      this.ref,
      this.strategy,
      ){
   print("KeyBuffer constructor called !!!!!");
  }

  String? addKey(BufferedKey key){
    //Before adding any key in the buffer, we need to test if it can impact other keys. Otherwise, it is unnecessary to add it to the buffer
    final outputString = ref.watch(inputTextProvider.notifier);
    if(_buffer.length == 0 && strategy.canBeBuffered(key)){
      _buffer.add(key);
    }else if(_buffer.length == 1){
      _buffer.add(key);
      KeyCombinationResult result = strategy.combine(_buffer);
      outputString.state += result.result;
      _buffer.clear();
    }else{
      outputString.state += key.key.getDisplayedCharacter(keyboardState: key.capturedState).toString();
    }
  }

  bool _canFormCombination(List<KeyObject> keys){

    if(keys.length == 2){
      KeyboardState state = ref.watch(keyboardStateProvider);
      return keys[0].keyOption.hasOption("accent_control");
    }
    return false;
  }

}