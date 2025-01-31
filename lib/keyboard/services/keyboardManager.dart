import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/KeyObject.dart';
import '../providers/keyboard_layout_provider.dart';

class KeyboardManager{

  List<List<KeyObject>> keyboardKeyLayout;

  KeyboardManager({
    this.keyboardKeyLayout = const [],
  });

  Future<void> populate(WidgetRef ref) async{
    //get access to the file content of the keyboard layout
    final jsonKeyboardLayout = await ref.read(jsonKeyboardLayoutProvider.future);
    //Number of rows in the keyboard
    int rowCount = jsonKeyboardLayout["layout"].length;
    //Temporary list of the keyboard layout so that it can overwrite the class variable
    List<List<KeyObject>> tempKeyLayout = [];
    for(int i = 0; i < rowCount; i++){
      int columnCount = jsonKeyboardLayout["layout"][i].length;
      List<KeyObject> row = [];
      for(int j = 0; j < columnCount; j++){
        row.add(KeyObject.fromJson(jsonKeyboardLayout["layout"][i][j]));
      }
      tempKeyLayout.add(row);
    }
    this.keyboardKeyLayout = tempKeyLayout;
  }
}