import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:virtual_keyboard/keyboard/models/KeyboardCustomState.dart';
import 'package:virtual_keyboard/keyboard/models/KeyboardState.dart';
import 'package:virtual_keyboard/keyboard/providers/keyboard_state_provider.dart';

final keyboardCustomStateProvider = StateProvider<KeyboardCustomState>((ref) => new KeyboardCustomState(0, "custom"));

void setState(WidgetRef ref,String state,int value,KeyboardState keyboardState){
  final keyboard_custom_state = ref.watch(keyboardCustomStateProvider.notifier);
  final keyboard_state = ref.watch(keyboardStateProvider.notifier);
  keyboard_state.state = keyboardState;
  keyboard_custom_state.state.setDescription(state);
  keyboard_custom_state.state.setValue(value);
  print(keyboard_custom_state.state.toString());
}

void changeState(WidgetRef ref,List<dynamic> states){
  final keyboardCustomState = ref.watch(keyboardCustomStateProvider.notifier);
  final keyboardState = ref.watch(keyboardStateProvider.notifier);
  if(states.length >= 2){
    if(keyboardCustomState.state.value == states.length-1){
      keyboardCustomState.state.setValue(0);
    }else{
      keyboardCustomState.state.setValue(keyboardCustomState.state.value + 1);
    }
    keyboardCustomState.state.setDescription(states[keyboardCustomState.state.value]);
    if(keyboardCustomState.state.description == "normal"){
      keyboardState.state = KeyboardState.normal;
    }else{
      keyboardState.state = KeyboardState.custom;
    }
  }else{
    if(keyboardCustomState.state.value == 0){
      keyboardCustomState.state.setValue(1);
      keyboardState.state = KeyboardState.custom;
    }else{
      keyboardCustomState.state.setValue(0);
      keyboardState.state = KeyboardState.normal;
    }
    keyboardCustomState.state.setDescription(states[keyboardCustomState.state.value]);
  }
  print(keyboardCustomState.state.toString());
}