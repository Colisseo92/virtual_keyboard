///Class that represent different state a keyboard can be in
///
/// - [normal] : State the keyboard is in by default
/// - [shifted] : State the keyboard is in when the shift key has been pressed | Allow access
/// to the shifted value of each key for the next key
/// - [alted] : State the keyboard is in when the altgr key has been pressed | Allow access
/// to the value of each key only obtainable by pressing altgr
/// - [capsLocked] : State the keyboard is in when the capslock key has been pressed | Allow access
/// to the shifted value of each key but until the capslock key is pressed again
enum KeyboardState{
  normal(value:0),
  shifted(value:1),
  alted(value:2),
  capsLocked(value:3);

  const KeyboardState({
    required this.value,
});

  final int value;
}