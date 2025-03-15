import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:virtual_keyboard/parameters/models/OptionTextSize.dart';
import 'package:virtual_keyboard/parameters/providers/TextSizeSliderProvider.dart';
import 'package:virtual_keyboard/parameters/providers/parameter_provider.dart';
import 'package:virtual_keyboard/parameters/services/ConfigFileManager.dart';
import 'package:virtual_keyboard/parameters/services/ParameterManager.dart';
import 'package:virtual_keyboard/theme/styles/ThemeCustomText.dart';

class ParameterTextSizePage extends ConsumerStatefulWidget {
  const ParameterTextSizePage({Key? key}) : super(key: key);

  @override
  _ParameterTextSizePageState createState() => _ParameterTextSizePageState();
}

class _ParameterTextSizePageState extends ConsumerState<ParameterTextSizePage> {
  @override
  Widget build(BuildContext context) {
    double _value = 2;
    return Scaffold(
      body: Consumer(builder: (context, ref, child){
        final param_provider = ref.watch(parameter_provider);
        final slider_provider = ref.watch(textSizeSliderProvider);
        return param_provider.when(
          error: (error,stack) => Text("Error : $error"),
          loading: () {
            return Center(child: CircularProgressIndicator());
          },
          data: (parameter){
            return Container(
              color: Colors.white,
              child: Column(
                children: [
                  Expanded(
                    flex:1,
                    child: Row(
                      children: [
                        Expanded(
                            flex:1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: ClipRect(
                                        child: Row(
                                          children: [
                                            IconButton(
                                              icon: Icon(Icons.arrow_back_ios_new, size:50),
                                              onPressed: () async {
                                                String size_parameter_value = OptionTextSize.fromNumber(slider_provider.toInt()).display;
                                                parameter.setParameter("policeSize", size_parameter_value);
                                                ConfigFileManager.updateConfig(parameter.toConfigFormat());
                                                Navigator.pop(context,'refresh');
                                              },
                                            ),
                                            Spacer(),
                                            IconButton(
                                              icon: Icon(Icons.close, size:50),
                                              onPressed: (){
                                                Navigator.popUntil(context,(predicate) => predicate.isFirst);
                                              },
                                            )
                                          ],
                                        )
                                    )
                                ),
                              ],
                            )
                        )
                      ],
                    ),
                  ),
                  Expanded(
                      flex:9,
                      child: Container(
                        color: Colors.white,
                        child: Column(
                          children: [
                            Slider(
                              min: 0.0,
                              max: 2,
                              value: ref.watch(textSizeSliderProvider),
                              divisions: 2,
                              onChanged: (newValue) => ref.read(textSizeSliderProvider.notifier).update(newValue),
                            ),
                            Center(
                              child: Text(
                                "Text Size : ${OptionTextSize.fromNumber(slider_provider.toInt()).display}",
                                style: ThemeCustomText.getBasicTextStyle(context,OptionTextSize.fromNumber(slider_provider.toInt())),
                              ),
                            ),
                            Center(
                              child: Text(
                                "Current Size : ${parameter.getParameter("policeSize").value}",
                                style: ThemeCustomText.getBasicTextStyle(context,OptionTextSize.fromNumber(slider_provider.toInt())),
                              ),
                            ),
                          ],
                        ),
                      )
                  ),
                ],
              ),
            );
          }
        );
      }),
    );
  }
}
