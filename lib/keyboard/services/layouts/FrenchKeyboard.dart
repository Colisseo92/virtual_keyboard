import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:virtual_keyboard/keyboard/models/KeyObject.dart';

import 'keyboardService.dart';

class FrenchKeyboard extends KeyboardService{

  @override
  String handleKeyPressed(KeyObject key, WidgetRef ref){
    return super.handleKeyPressed(key, ref);
  }
}