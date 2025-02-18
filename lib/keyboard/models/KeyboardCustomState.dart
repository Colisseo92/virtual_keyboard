class KeyboardCustomState{

  int value;
  String description;

  KeyboardCustomState(
      this.value,
      this.description,
      );

  @override
  String toString() => 'CustomState(value:$value,description:$description)';

  void setDescription(String description){
    this.description = description;
  }

  void setValue(int value){
    this.value = value;
  }
}