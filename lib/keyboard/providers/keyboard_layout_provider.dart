import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final jsonKeyboardLayoutProvider = FutureProvider<Map<String,dynamic>>((ref) async{
  final String jsonString = await rootBundle.loadString('assets/keyboard/languages/french_phone.json');
  return json.decode(jsonString);
});