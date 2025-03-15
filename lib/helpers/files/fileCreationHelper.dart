import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileCreationHelper{

  static const String filename = "config.json";

  static Future<File> _getFile() async{
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/$filename');
  }

  static Future<bool> _fileExists() async{
    final file = await _getFile();
    return file.exists();
  }

}