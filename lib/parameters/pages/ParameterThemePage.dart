
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:virtual_keyboard/parameters/providers/parameter_provider.dart';
import 'package:virtual_keyboard/parameters/providers/theme_checkbox_selection_provider.dart';
import 'package:virtual_keyboard/parameters/services/ConfigFileManager.dart';
import 'package:virtual_keyboard/parameters/widgets/themeSelectionWidget.dart';
import 'package:virtual_keyboard/theme/models/Themes.dart';

class ParameterThemePage extends ConsumerStatefulWidget {
  const ParameterThemePage({Key? key}) : super(key: key);

  @override
  _ParameterThemePageState createState() => _ParameterThemePageState();
}

class _ParameterThemePageState extends ConsumerState<ParameterThemePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(builder: (context, ref, child){
        final param_provider = ref.watch(parameter_provider);
        final isFirstBuild = ref.watch(themeWindowFirstBuildProvider);
        return param_provider.when(
          error: (error,stack) => Text("Error: $error"),
          loading: () => CircularProgressIndicator(),
          data: (parameter){
            if(isFirstBuild){
              Future.microtask((){
                ref.read(themeWindowFirstBuildProvider.notifier).state = false;
                ref.read(themeCheckboxSelectionProvider.notifier).state = Themes.fromString(parameter.getParameter("theme").value).id;
              });
            }
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
                                              onPressed: (){
                                                parameter.setParameter("theme",Themes.fromId(ref.watch(themeCheckboxSelectionProvider)).name);
                                                ConfigFileManager.updateConfig(parameter.toConfigFormat());
                                                Navigator.pop(context);
                                                print(parameter.toString());
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
                            Expanded(
                              child: Container(
                                color: Colors.white,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: ThemeSelectionWidget(id:1),
                                    ),
                                    Expanded(
                                      child: ThemeSelectionWidget(id:2),
                                    ),
                                    Expanded(
                                      child: ThemeSelectionWidget(id:3),
                                    ),
                                  ],
                                ),
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