import 'dart:ui';

/// Type of keyboard key
///
/// - [character] : letters and number
/// - [control] : alt,shift,ctrl,altgr type of key
/// - [special] : enter, backspace, tab
/// - [toggle] : capsLock, numLock
/// - [symbol] : punctuation or special character
/// - [mixed] : when the key is a mix of all the above
enum KeyType {
  character("character",Color.fromRGBO(249, 202, 36,1.0)),
  control("control",Color.fromRGBO(106, 176, 76,1.0)),
  special("special",Color.fromRGBO(126, 214, 223,1.0)),
  toggle("toggle",Color.fromRGBO(190, 46, 221,1.0)),
  symbol("symbol",Color.fromRGBO(240, 147, 43,1.0)),
  mixed("mixed",Color.fromRGBO(255, 190, 118,1.0)),
  number("number",Color.fromRGBO(255, 121, 121,1.0)),
  none("none",Color.fromRGBO(83, 92, 104,1.0));

  const KeyType(
    this.value,
    this.debugColor,
  );

  final String value;
  final Color debugColor;

  static KeyType fromString(String value){
    return KeyType.values.firstWhere((e) => e.value == value, orElse: () => KeyType.none);
  }
}
