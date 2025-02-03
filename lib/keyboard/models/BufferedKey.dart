import 'package:virtual_keyboard/keyboard/models/KeyObject.dart';
import 'package:virtual_keyboard/keyboard/models/KeyboardState.dart';

///When a key is added to the buffer, it is important to know wich state it was in before
///For that matter, instead of only storing the key, that can indeed get access to the state
///(that could've change), we store the key and the state at that time in an object -> BufferedKey
class BufferedKey{

  final KeyObject key;
  final KeyboardState capturedState;

  BufferedKey({
    required this.key,
    required this.capturedState,
  });

  @override
  String toString(){
    return '{key: $key, state:$capturedState}';
  }

}