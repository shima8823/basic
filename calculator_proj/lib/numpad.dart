import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'button.dart';
import 'calculate_state.dart';

Widget numpad(BuildContext context) {
  return GridView.builder(
    shrinkWrap: true,
    itemCount: buttons.length,
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 5,
      childAspectRatio: MediaQuery.of(context).size.width /
          (MediaQuery.of(context).size.height / 2.0),
    ),
    padding: EdgeInsets.zero,
    itemBuilder: (BuildContext context, int index) {
      if (index == buttons.length - 1) {
        return Container(
          color: Colors.indigo[300],
        );
      }
      return calcButton(context, buttons[index].text, buttons[index].textColor,
          buttons[index].buttonType);
    },
  );
}

Widget calcButton(BuildContext context, String buttonText, Color buttonColor,
    ButtonType buttonType) {
  final appState = context.watch<MainAppState>();
  void buttonPressed() {
    try {
      switch (buttonType) {
        case ButtonType.num:
          appState.numClick(buttonText);
          break;
        case ButtonType.operator:
          appState.operatorClick(buttonText);
          break;
      }
    } catch (e) {
      appState.initialize();
      appState.resultText = "Format Error";
    }
  }

  ;

  return Center(
      child: RawMaterialButton(
    onPressed: buttonPressed,
    fillColor: Colors.indigo[300],
    constraints: const BoxConstraints.expand(),
    child: Text(buttonText, style: TextStyle(color: buttonColor, fontSize: 24)),
  ));
}
