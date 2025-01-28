import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:virtual_keyboard/keyboard/KeyboardState.dart';

final keyboardStateProvider = StateProvider<KeyboardState>((ref) => KeyboardState.normal);

final keyboardTextProvider = StateProvider<String>((ref) => "");