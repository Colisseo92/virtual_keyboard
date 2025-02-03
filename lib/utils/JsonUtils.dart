Map<String,String> convertJsonMap(object){
  Map<String,String> result = {};
  object.forEach((key,value){
    result[key.toString()] = value.toString();
  });
  return result;
}