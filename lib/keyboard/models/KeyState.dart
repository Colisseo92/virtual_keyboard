enum KeyState {
  normal(value: 0),
  held(value: 1),
  disabled(value: 2);

  const KeyState({
    required this.value,
  });

  final int value;
}
