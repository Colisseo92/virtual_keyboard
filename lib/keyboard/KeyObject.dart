import 'models/KeyboardState.dart';

class KeyObject {
  String primary_text;
  String shift_text;
  int key_size;

  bool
      is_holdable; //means that it is possible to click once on the key to hold it pressed down.
  bool is_hold; //boolean that represent the state the key is in (hold or not)
  KeyboardState
      state; //state of the keyboard to track if the shift key is activated

  Function? function;

  KeyObject(
    this.primary_text,
    this.shift_text,
    this.key_size,
    this.state, {
    this.is_holdable = false,
    this.is_hold = false,
  }) {
    this.function ??= _default_function;
  }

  void changeHoldState() {
    this.is_hold = !this.is_hold;
    this.state = this.state == KeyboardState.normal
        ? KeyboardState.shifted
        : KeyboardState.normal;
  }

  void _default_function() {
    print(this.primary_text);
  }

  String getKeyDisplayedString() {
    if (state == KeyboardState.normal) {
      return this.primary_text;
    } else if (state == KeyboardState.shifted) {
      return this.shift_text;
    } else {
      return this.primary_text;
    }
  }
}
