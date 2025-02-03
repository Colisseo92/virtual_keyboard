import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:virtual_keyboard/keyboard/models/KeyboardState.dart';

final keyboardStateProvider =
    StateProvider<KeyboardState>((ref) => KeyboardState.normal);

///Function to toggle the shift state on the keyboard
void toggleShift(StateController<KeyboardState> stateController){
    if(stateController.state == KeyboardState.shifted){
        stateController.state = KeyboardState.normal;
    }else{
        stateController.state = KeyboardState.shifted;
    }
}

///Function to toggle the altgr button on the keyboard
void toggleAlted(StateController<KeyboardState> stateController){
    if(stateController.state == KeyboardState.alted){
        stateController.state = KeyboardState.normal;
    }else{
        stateController.state = KeyboardState.alted;
    }
}

///Function to toggle the CapsLock button on the keyboard
void toggleCapsLock(WidgetRef ref){
    final keyboardState = ref.watch(keyboardStateProvider.notifier);
    if(keyboardState.state == KeyboardState.capsLocked){
        keyboardState.state = KeyboardState.normal;
    }else{
        keyboardState.state = KeyboardState.capsLocked;
    }
}

///Change back to normal the keyboard state
void reset(StateController<KeyboardState> stateController){
    stateController.state = KeyboardState.normal;
}