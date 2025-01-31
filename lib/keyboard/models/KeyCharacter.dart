import 'package:virtual_keyboard/keyboard/models/KeyAction.dart';

///Class that describe each action of a key
///
///for example, what's the KeyCharacter when shift is pressed or when control is pressed
///
/// - [_keyAction] : Key Action state
/// - [_character] : what is returned when the key is pressed in this particular state
class KeyCharacter{

  final KeyAction _keyAction;
  final String _character;

  const KeyCharacter(
      this._keyAction,
      this._character,
      );

  String get character => _character;
  KeyAction get keyAction => _keyAction;

  ///Function that take a json string and convert it to a KeyCharacter object
  ///
  /// Used for generating keyboard layout from a json file
  factory KeyCharacter.fromJson(Map<String, dynamic> json){
    return KeyCharacter(
      KeyAction.fromString(json['key_action']),
      json['character'],
    );
  }

  @override
  String toString(){
    return 'KeyCharacter(action: $_keyAction, character: $_character)';
  }
}