import 'package:virtual_keyboard/keyboard/models/BufferedKey.dart';
import 'package:virtual_keyboard/keyboard/models/KeyCombinationResult.dart';
import 'package:virtual_keyboard/keyboard/models/KeyObject.dart';

abstract class StringBufferStrategy{

  bool canBeBuffered(BufferedKey key);

  bool canCombine(List<BufferedKey> buffer);

  KeyCombinationResult combine(List<BufferedKey> buffer);

  String flush(List<BufferedKey> buffer);

}