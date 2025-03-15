class Option{

  String name;
  String value;

  Option({
   this.name = "none",
   this.value = "none",
  });

  factory Option.fromJson(Map<String,dynamic> json){
    return Option(
      name: json.keys.first,
      value: json.values.first,
    );
  }

  @override
  String toString() {
    return 'name: $name | value: $value';
  }

}