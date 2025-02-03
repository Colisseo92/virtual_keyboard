import 'package:virtual_keyboard/keyboard/models/BufferedKey.dart';
import 'package:virtual_keyboard/keyboard/models/CombinationOutcome.dart';
import 'package:virtual_keyboard/keyboard/models/KeyCombinationResult.dart';
import 'package:virtual_keyboard/keyboard/models/KeyObject.dart';
import 'package:virtual_keyboard/keyboard/models/KeyType.dart';
import 'package:virtual_keyboard/keyboard/strategies/string_buffer_strategy.dart';
import 'package:virtual_keyboard/utils/JsonUtils.dart';
import 'package:virtual_keyboard/utils/StringUtils.dart';

class FrenchStringBufferStrategy implements StringBufferStrategy {

  @override
  bool canBeBuffered(BufferedKey bufferedKey){
    return bufferedKey.key.keyOption.hasOption("accent_control");
  }

  @override
  bool canCombine(List<BufferedKey> buffer) {
    print("Combination task :");
    return buffer[0].key.keyOption.getOption("accent_control");
    return true;
  }

  @override
  KeyCombinationResult combine(List<BufferedKey> buffer) {
    //Add verification of option ?
    BufferedKey first_key = buffer[0]; //BufferedKey object of the first key (that should be an accent)
    BufferedKey second_key = buffer[1];
    //Retrieving the actual accent that is wanted (the accent displayed when the key was pressed)
    String first_key_displayed_character = buffer[0].key.getDisplayedCharacter(keyboardState: first_key.capturedState);
    //Retrieving the options of the key (because it
    String second_key_displayed_character = buffer[1].key.getDisplayedCharacter(keyboardState: second_key.capturedState);
    Map<String,dynamic> options = first_key.key.keyOption.getOption("accent_control");
    if(options.containsKey(first_key_displayed_character)){
      Map<String,String> option = convertJsonMap(options[first_key_displayed_character]);
      if(option.containsKey(second_key_displayed_character)){
        return KeyCombinationResult(CombinationOutcome.combined, option[second_key_displayed_character].toString());
      }else{
        switch(second_key_displayed_character){
          case "alt" || "Entrée":
            return KeyCombinationResult(CombinationOutcome.cleared, "");
          case "tab":
            return KeyCombinationResult(CombinationOutcome.cleared, multiplyString(" ", 4));
          case "ctrl" || "shift" || "Fn":
            //To change later cause if a third key is entered, the outcome could change.
            return KeyCombinationResult(CombinationOutcome.cleared, "");
          case "___":
            return KeyCombinationResult(CombinationOutcome.accentOnly, "$first_key_displayed_character");
        }
      }
      return KeyCombinationResult(CombinationOutcome.separated, "$first_key_displayed_character$second_key_displayed_character");
    }
    return KeyCombinationResult(CombinationOutcome.separated, "$first_key_displayed_character$second_key_displayed_character");
  }

  @override
  String flush(List<BufferedKey> buffer) {
    // TODO: implement flush
    throw UnimplementedError();
  }


}