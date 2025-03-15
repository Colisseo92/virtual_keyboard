import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:virtual_keyboard/parameters/providers/parameter_provider.dart';
import 'package:virtual_keyboard/parameters/providers/theme_checkbox_selection_provider.dart';
import 'package:virtual_keyboard/theme/models/Themes.dart';

class ThemeSelectionWidget extends ConsumerStatefulWidget {
  final int id;
  const ThemeSelectionWidget({Key? key, required this.id,}) : super(key: key);

  @override
  _ThemeSelectionWidgetState createState() => _ThemeSelectionWidgetState();
}

class _ThemeSelectionWidgetState extends ConsumerState<ThemeSelectionWidget> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(builder: (context, ref, child){
        print(widget.id);
        print(ref.watch(themeCheckboxSelectionProvider));
        final param_provider = ref.watch(parameter_provider);
        return param_provider.when(
          error: (error,stack) => Text("Error: $error"),
          loading: () => CircularProgressIndicator(),
          data: (parameter){
            return LayoutBuilder(builder: (context, constraints){
              final size = min(constraints.maxWidth, constraints.maxHeight);
              return Container(
                color: Colors.white,
                child: Center(
                  child: ElevatedButton(
                      onPressed: (){
                        print("clicked ${widget.id}");
                        ref.read(themeCheckboxSelectionProvider.notifier).state = widget.id;
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ref.watch(themeCheckboxSelectionProvider) == widget.id ? Colors.purple : Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        minimumSize: Size(size/2,size/2),
                        maximumSize: Size(size/2,size/2),
                        shadowColor: Colors.transparent,
                      ),
                      child: Text("${Themes.fromId(widget.id).name}"),
                  ),
                ),
              );
            });
          }
        );
      }),
    );
  }
}