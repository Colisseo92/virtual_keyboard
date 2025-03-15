import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:virtual_keyboard/parameters/models/OptionTextSize.dart';
import 'package:virtual_keyboard/parameters/providers/parameter_provider.dart';

class TextSizeSliderProvider extends StateNotifier<double>{
  TextSizeSliderProvider(double value) : super(value);

  void update(double newValue) => state = newValue;
}

final textSizeSliderProvider = StateNotifierProvider<TextSizeSliderProvider, double>((ref){
  return TextSizeSliderProvider(0);
});