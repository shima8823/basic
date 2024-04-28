import 'package:calculator_proj/numpad.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'calculate_state.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MainAppState(),
      child: const MaterialApp(
        title: 'Calculator',
        home: Calculator(),
      ),
    );
  }
}

class Calculator extends StatelessWidget {
  const Calculator({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MainAppState>();
    final textSize = (MediaQuery.of(context).orientation == Orientation.portrait
        ? MediaQuery.of(context).size.width / 12
        : MediaQuery.of(context).size.width / 22);
    return Scaffold(
        backgroundColor: Colors.indigo[900],
        appBar: AppBar(
          centerTitle: true,
          title:
              const Text('Calculator', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.indigo[300],
        ),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(appState.equation,
                      style: TextStyle(
                          color: Colors.indigo[200], fontSize: textSize)),
                  Text(appState.resultText,
                      style: TextStyle(
                          color: Colors.indigo[200], fontSize: textSize)),
                ],
              ),
              const Spacer(),
              numpad(context)
            ]));
  }
}
