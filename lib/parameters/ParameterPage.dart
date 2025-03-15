
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:virtual_keyboard/parameters/models/OptionTextSize.dart';
import 'package:virtual_keyboard/parameters/pages/ParameterTextSizePage.dart';
import 'package:virtual_keyboard/parameters/pages/ParameterThemePage.dart';
import 'package:virtual_keyboard/parameters/providers/parameter_provider.dart';
import 'package:virtual_keyboard/parameters/services/ParameterManager.dart';
import 'package:virtual_keyboard/theme/styles/ThemeCustomText.dart';

class ParameterPage extends ConsumerStatefulWidget {

  const ParameterPage({Key? key}) : super(key: key);

  @override
  _ParameterPageState createState() => _ParameterPageState();
}

class _ParameterPageState extends ConsumerState<ParameterPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(builder: (context, ref, child){
      final param_provider = ref.watch(parameter_provider);
      return param_provider.when(
        error: (error,stack) => Text("Error : $error"),
        loading: () {
          return Center(child: CircularProgressIndicator());
        },
        data: (parameter){
          OptionTextSize optionTextSize = OptionTextSize.fromString(parameter.getParameter("policeSize").value);
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
                                child: Wrap(
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.arrow_back_ios_new, size:50),
                                      onPressed: (){
                                        Navigator.pop(context);
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
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          color: Colors.white,
                          child: ListTile(
                            leading: Icon(Icons.format_size, size: ThemeCustomText.getBasicTextSize(context, optionTextSize)),
                            title: Text(
                              AppLocalizations.of(context)!.first_setting,
                              style: ThemeCustomText.getBasicTextStyle(context, optionTextSize),
                            ),
                            onTap: () async {
                              final result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => ParameterTextSizePage()));
                              if(result == 'refresh'){
                                setState((){});
                              }
                            },
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          child: ListTile(
                            leading: Icon(Icons.palette,size: ThemeCustomText.getBasicTextSize(context, optionTextSize),),
                            title: Text(
                                AppLocalizations.of(context)!.second_setting,
                              style: ThemeCustomText.getBasicTextStyle(context, optionTextSize),
                            ),
                            onTap: (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const ParameterThemePage()));
                            },
                          ),
                        ),
                      ]
                    ),
                  )
                ),
              ],
            ),
          );
        });
      }),
    );
  }
}