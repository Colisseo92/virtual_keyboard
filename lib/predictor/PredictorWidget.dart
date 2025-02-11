
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:virtual_keyboard/keyboard/providers/input_text_provider.dart';
import 'package:virtual_keyboard/predictor/models/Prediction.dart';

class PredictorWidget extends ConsumerWidget {

  Prediction prediction;

  PredictorWidget(
      ref,
      this.prediction,
      {
        Key? key,
      }) : super(key: key);

  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Row(
        children: List.generate(
          prediction.predictions.length,
            (index) {
            return Expanded(
              flex: 1,
              child: Container(
                color: Colors.orange[index*100],
                alignment: Alignment.center,
                child: TextButton(
                    onPressed: (){
                      final outputString = ref.watch(inputTextProvider.notifier);
                      outputString.state += " " + prediction.predictions[index].toString();
                    },
                    child: Text(
                      prediction.predictions[index].toString(),
                    )
                ),
              ),
            );
            }
        )
      ),
    );
  }

}
