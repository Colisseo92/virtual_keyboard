///Class that models a key state
///
/// Parameters:
/// - [normal] : Basic key state each key are in by default. Allows interractions.
/// - [held] : Keys that can be pressed and are supposed to be hold for a certain
/// action to happen are temporarily in that state
/// - [disabled] : If for some reason a key shouldn't be used or can't be used, it will be in this
/// state
enum KeyState {
  normal("normal"),
  held("held"),
  disabled("disabled");

  const KeyState(
    this.value,
  );

  final String value;

  static KeyState fromString(String value){
    return KeyState.values.firstWhere((e) => e.value == value, orElse: () => KeyState.normal);
  }
}
