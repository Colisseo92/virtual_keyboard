import 'dart:ui';

///Actions executable by a key
///
/// - [delete] : Keys that can delete what's been written
/// - [input] : Any key that can add something to the existing text
/// - [submit] : Special key like enter that, when pressed, can execute special actions
/// such as submitting forms
/// - [modifier] : Keys that, when pressed, will modify the output of the next key like special accent
/// or shift key
/// - [toggle] : Keys that, when pressed, will stay in there activated state until they are pressed again.
/// Mainly used for the CapsLock or NumLock key.
/// - [none] : When a key doesn't perform any action (just in case)
enum KeyAction {
  delete("delete",Color.fromRGBO(231, 76, 60,1.0)), //backspace, delete
  input("input",Color.fromRGBO(243, 156, 18,1.0)),
  submit("submit",Color.fromRGBO(52, 152, 219,1.0)), //enter key or other key that have the same behavior
  modifier("modifier",Color.fromRGBO(26, 188, 156,1.0)), //modify next key form
  toggle("toggle",Color.fromRGBO(142, 68, 173,1.0)), //Toggle a key permanently
  none("none",Color.fromRGBO(44, 62, 80,1.0));

  final String value;
  final Color debugColor;

  const KeyAction(
    this.value,
      this.debugColor,
  );

  static KeyAction fromString(String value){
    return KeyAction.values.firstWhere((e) => e.value == value, orElse: () => KeyAction.none);
  }
}
