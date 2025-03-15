import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class ConfigFileManager{

  static const String filename = "config.json";

  static Future<File> _getFile() async{
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/$filename');
  }

  static Future<bool> _fileExists() async{
    final file = await _getFile();
    return file.exists();
  }

  static Future<void> createConfigFileIfNotExists() async{
    if(await _fileExists()){
      print("Config file already exists.");
      return;
    }

    final file = await _getFile();
    Map<String,dynamic> defaultConfig = {
      "theme" : "light",
      "language" : "fr",
      "policeSize" : "normal",
    };

    await file.writeAsString(jsonEncode(defaultConfig));
    print("Config file created.");
  }

  static Future<Map<String,dynamic>> loadConfig() async{
    final file = await _getFile();

    if(!(await file.exists())){
      await createConfigFileIfNotExists();
    }

    String content = await file.readAsString();
    return jsonDecode(content);
  }

  static Future<void> updateConfig(Map<String,dynamic>? newConfig) async{
    if(newConfig!.isNotEmpty){
      final file = await _getFile();
      await file.writeAsString(jsonEncode(newConfig));
    }
  }

}