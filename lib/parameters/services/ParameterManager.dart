import 'package:virtual_keyboard/parameters/models/Option.dart';

class Parameter{
  
  List<Option> options = [];
  
  Parameter({
    required this.options
  }){}
  
  factory Parameter.fromJson(Map<String,dynamic> json){
    List<Option> optionsList = [];

    json.forEach((key,value){
      optionsList.add(Option(name: key, value: value));
    });

    return Parameter(options: optionsList);
  }

  bool doesParameterExists(String value){
    bool returned = false;
    options.forEach((option){
      if(option.name == value){
        returned = true;
      }
    });
    return returned;
  }

  Option getParameter(String value){
    Option returned = Option();
    options.forEach((option){
      if(option.name == value){
        returned = option;
      }
    });
    return returned;
  }

  void setParameter(String name, String value){
    options.forEach((option){
      if(option.name == name){
        option.value = value;
      }
    });
  }

  @override
  String toString(){
    String text = "";
    options.forEach((options){
      text += options.toString() + "\n";
    });
    return text;
  }

  Map<String,dynamic> toConfigFormat(){
    Map<String,dynamic> config = {};
    options.forEach((option){
      config[option.name] = option.value;
    });
    return config;
  }
  
}