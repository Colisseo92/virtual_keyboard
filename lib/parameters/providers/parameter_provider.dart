

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:virtual_keyboard/parameters/services/ConfigFileManager.dart';
import 'package:virtual_keyboard/parameters/services/ParameterManager.dart';

final parameter_provider = FutureProvider<Parameter>((ref) async{
  return Parameter.fromJson(await ConfigFileManager.loadConfig());
});