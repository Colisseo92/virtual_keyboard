
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:virtual_keyboard/keyboard/providers/input_text_provider.dart';
import 'package:virtual_keyboard/parameters/models/OptionTextSize.dart';
import 'package:virtual_keyboard/parameters/providers/parameter_provider.dart';
import 'package:virtual_keyboard/predictor/models/Prediction.dart';
import 'package:virtual_keyboard/theme/models/Themes.dart';
import 'package:virtual_keyboard/theme/styles/ThemeCustomText.dart';

class PredictorWidget extends ConsumerWidget {

  Prediction prediction;

  PredictorWidget(
      ref,
      this.prediction,
      {
        Key? key,
      }) : super(key: key);

  Widget build(BuildContext context, WidgetRef ref) {
    return Consumer(builder: (context,ref,child){
      final param_provider = ref.watch(parameter_provider);
      return param_provider.when(
        error: (error,stack) => Text("Error: $error"),
        loading: (){
          return CircularProgressIndicator();
        },
        data: (parameter){
          OptionTextSize optionTextSize = OptionTextSize.fromString(parameter.getParameter("policeSize").value);
          Themes currentTheme = Themes.fromString(parameter.getParameter("theme").value);
          return SafeArea(
            child: Row(
                children: List.generate(
                    prediction.predictions.length,
                        (index) {
                      return Expanded(
                        flex: 1,
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: currentTheme.keyColor,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: currentTheme.shadowColor,
                                offset: Offset(-1, -1),
                                blurRadius: 10,
                              ),
                              BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, 0.2),
                                offset: Offset(-1,-1),
                                blurRadius: 10,
                              )
                            ],
                          ),
                          child: SizedBox.expand(
                            child: MaterialButton(
                              //A modifie pour traiter complétion et prédiction
                                onPressed: (){
                                  final outputString = ref.watch(inputTextProvider.notifier);
                                  if(prediction.type == "completion"){
                                    List splited = outputString.state.split(" ");
                                    splited.removeLast();
                                    splited.add(prediction.predictions[index].toString());
                                    outputString.state = splited.join(" ");
                                  }
                                  if(prediction.type == "prediction"){
                                    outputString.state += prediction.predictions[index].toString() + " ";
                                  }
                                },
                                hoverColor: Colors.purple,
                                splashColor: Colors.transparent,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                child: Text(
                                  prediction.predictions[index].toString(),
                                  style: TextStyle(
                                    fontSize: ThemeCustomText.getBasicTextSize(context, optionTextSize)/2,
                                    color: currentTheme.textColor,
                                  ),
                                )
                            ),
                          ),
                        ),
                      );
                    }
                )
            ),
          );
        }
      );
    },
    );
  }

}
