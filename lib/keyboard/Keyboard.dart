import 'package:flutter/cupertino.dart';
import 'package:virtual_keyboard/keyboard/KeyWidget.dart';

class KeyboardWidget extends StatefulWidget {
  bool state;
  
  KeyboardWidget({
    Key? key,
    //required this.key_layout,
    required this.state,
  }): super(key: key);

  @override
  State<KeyboardWidget> createState() => _KeyboardWidgetState();
}

class _KeyboardWidgetState extends State<KeyboardWidget> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints){
          final double width = (constraints.maxWidth - 9*8)/10;
          final double height = (constraints.maxHeight - 9*8)/10;
          return Row(
              spacing: 8,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                  10,
                  (index)=> KeyWidgetButton(state: widget.state, width: width, height: height)
                  )
          );
        }
    );
  }
}

