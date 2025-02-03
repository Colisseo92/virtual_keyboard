class KeyOption{

  final Map<String, dynamic> options;

  const KeyOption({
    this.options = const {},
  });

  bool hasOptions(){
    return options.isNotEmpty;
  }

  bool hasOption(String option){
    return options.containsKey(option);
  }

  dynamic getOption(String option){
    return hasOption(option) ? options[option] : null;
  }

  factory KeyOption.fromJson(Map<String,dynamic> json){
    return KeyOption(
      options: json as Map<String,dynamic>? ?? {},
    );
  }

  @override
  String toString(){
    return '$options';
  }

}