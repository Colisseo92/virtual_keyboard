import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:virtual_keyboard/keyboard/models/BufferedKey.dart';
import 'package:virtual_keyboard/keyboard/models/KeyObject.dart';
import 'package:virtual_keyboard/keyboard/providers/input_text_provider.dart';
import 'package:virtual_keyboard/keyboard/services/KeyBuffer.dart';

import 'keyboardService.dart';

class FrenchKeyboard extends KeyboardService{

  @override
  String handleKeyPressed(BufferedKey buffered_key, WidgetRef ref, KeyBuffer buffer){
    String super_result = super.handleKeyPressed(buffered_key, ref, buffer);
    if(super_result == "<default>"){
      buffer.addKey(buffered_key);
    }else{
      final outputString = ref.watch(inputTextProvider.notifier);
      outputString.state += super_result;
    }
    return super_result;
  }
}