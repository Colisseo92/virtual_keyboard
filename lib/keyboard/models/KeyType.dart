enum KeyType {
  character(value: 0), //basic alphabet key
  control(value: 1),
  special(value: 2),
  toggle(value: 3),
  symbol(value: 4), //punctuation or special character
  mixed(value: 5);

  const KeyType({
    required this.value,
  });

  final int value;
}
