import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:virtual_keyboard/keyboard/models/KeyAction.dart';
import 'package:virtual_keyboard/keyboard/models/KeyCharacter.dart';
import 'package:virtual_keyboard/keyboard/models/KeyOption.dart';
import 'package:virtual_keyboard/keyboard/models/KeyState.dart';
import 'package:virtual_keyboard/keyboard/models/KeyType.dart';
import 'package:virtual_keyboard/keyboard/models/KeyboardState.dart';
import 'package:virtual_keyboard/keyboard/providers/input_text_provider.dart';
import 'package:virtual_keyboard/keyboard/providers/keyboard_state_provider.dart';

/// Class that models a keyboard key
///
/// Parameters:
///
/// - [baseCharacter] : Character displayed by default
/// - [shiftCharacter] : Character displayed when the shift key is either pressed or held
/// - [altgrCharacter] : Character displayed when the altgr key is pressed
/// - [keyAction] : Type of action the key execute when pressed
/// - [keyState] : State of the key. (normal) - key is active | (disabled) - key is not usable | (held) - key is held
/// - [keyType] : Type of key
class KeyObject{

  KeyCharacter baseCharacter;
  KeyCharacter shiftCharacter;
  KeyCharacter altgrCharacter;
  KeyCharacter capsLockCharacter;

  KeyState keyState;
  KeyType keyType;

  KeyOption keyOption;

  int keySize;

  Function? function;

  KeyObject(
      this.baseCharacter,
      this.keyType,
      {
        this.keyState = KeyState.normal,
        this.keySize = 1,
        this.shiftCharacter = const KeyCharacter(KeyAction.none, ""),
        this.altgrCharacter = const KeyCharacter(KeyAction.none, ""),
        this.capsLockCharacter = const KeyCharacter(KeyAction.none, ""),
        this.keyOption = const KeyOption(),
      }
      ){
    this.function ??= default_function;
  }

  factory KeyObject.fromJson(Map<String, dynamic> json){
    return KeyObject(
      KeyCharacter.fromJson(json['base_character']),
      KeyType.fromString(json['key_type']),
      keyState: KeyState.fromString(json['key_state']),
      keySize: json['key_size'],
      shiftCharacter: KeyCharacter.fromJson(json['shift_character']),
      altgrCharacter: KeyCharacter.fromJson(json['altgr_character']),
      capsLockCharacter: KeyCharacter.fromJson(json['caps_lock_character']),
      keyOption: json.containsKey('options') ? KeyOption.fromJson(json['options'] as Map<String,dynamic>) : KeyOption(),
    );
  }

  ///Default function executed when the key is pressed
  ///
  /// - [keyboardState] : state of the keyboard
  /// - []
  void default_function(WidgetRef ref){
    print(this.baseCharacter);
  }

  /// Return the value that should be displayed on the key based on they [keyboardState]:
  ///
  /// - if [keyboardState] is [KeyboardState.normal] return the basic character of the key (when nothing else is pressed).
  /// - if [keyboardState] is [KeyboardState.shifted] return the character that the key takes when the shift key is held.
  /// - if [keyboardState] is [KeyboardState.alted] return the character that the key takes when the altgr key is held.
  ///
  /// Otherwise it returns an empty "" string.a
  String getDisplayedCharacter({
    KeyboardState keyboardState = KeyboardState.normal
  }){
    switch(keyboardState){
      case KeyboardState.normal:
        return this.baseCharacter.character;
        break;
      case KeyboardState.shifted:
        return this.shiftCharacter.character;
        break;
      case KeyboardState.alted:
        return this.altgrCharacter.character;
        break;
      case KeyboardState.capsLocked:
        return this.capsLockCharacter.character;
        break;
      default:
        return "";
    }
  }

  bool canGetAccent({
    KeyboardState keyboardState = KeyboardState.normal,
    String accent = "",
  }){
    if(keyOption.hasOption("accent_control")){
      String displayedCharacter = getDisplayedCharacter(keyboardState: keyboardState);
      Map<String,Map<String,String>> accents = keyOption.getOption("accent_control");
      if(accents[accent]!.containsKey(displayedCharacter)){
        return true;
      }
    }
    return false;
  }

  @override
  String toString(){
    return 'KeyObject(baseCharacter: $baseCharacter, shiftCharacter: $shiftCharacter, altgrCharacter:$altgrCharacter, caps_lock_character: $capsLockCharacter,keyState: $keyState, keyType: $keyType, keyOption: $keyOption)';
  }

}