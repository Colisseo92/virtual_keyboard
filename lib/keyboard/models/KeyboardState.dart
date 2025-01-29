enum KeyboardState{
  normal(value:0),
  shifted(value:1),
  alted(value:2);

  const KeyboardState({
    required this.value,
});

  final int value;
}