import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MainApp());
}

class MainAppState extends ChangeNotifier {
  String equation = "0";
  String result = "0";
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MainAppState(),
      child: MaterialApp(
        title: 'Calculator',
        home: HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final buttons = [
    CalculatorButton(
        text: '7',
        textColor: Colors.black,
        onPressed: () {
          print('button pressed :7');
        },
      ),
      CalculatorButton(
        text: '8',
        textColor: Colors.black,
        onPressed: () {
          print('button pressed :8');
        },
      ),
      CalculatorButton(
        text: '9',
        textColor: Colors.black,
        onPressed: () {
          print('button pressed :9');
        },
      ),
      CalculatorButton(
        text: 'C',
        textColor: Colors.red,
        onPressed: () {
          print('button pressed :C');
        },
      ),
      CalculatorButton(
        text: 'AC',
        textColor: Colors.red,
        onPressed: () {
          print('button pressed :AC');
        },
      ),
      CalculatorButton(
        text: '4',
        textColor: Colors.black,
        onPressed: () {
          print('button pressed :4');
        },
      ),
      CalculatorButton(
        text: '5',
        textColor: Colors.black,
        onPressed: () {
          print('button pressed :5');
        },
      ),
      CalculatorButton(
        text: '6',
        textColor: Colors.black,
        onPressed: () {
          print('button pressed :6');
        },
      ),
      CalculatorButton(
        text: '+',
        textColor: Colors.white,
        onPressed: () {
          print('button pressed :+');
        },
      ),
      // - minus button
      CalculatorButton(
        text: '-',
        textColor: Colors.white,
        onPressed: () {
          print('button pressed :-');
        },
      ),
      CalculatorButton(
        text: '1',
        textColor: Colors.black,
        onPressed: () {
          print('button pressed :1');
        },
      ),
      CalculatorButton(
        text: '2',
        textColor: Colors.black,
        onPressed: () {
          print('button pressed :2');
        },
      ),
      CalculatorButton(
        text: '3',
        textColor: Colors.black,
        onPressed: () {
          print('button pressed :3');
        },
      ),
      CalculatorButton(
        text: '×',
        textColor: Colors.white,
        onPressed: () {
          print('button pressed :×');
        },
      ),
      CalculatorButton(
        text: '/',
        textColor: Colors.white,
        onPressed: () {
          print('button pressed :/');
        },
      ),
      CalculatorButton(
        text: '0',
        textColor: Colors.black,
        onPressed: () {
          print('button pressed :0');
        },
      ),
      CalculatorButton(
        text: '.',
        textColor: Colors.black,
        onPressed: () {
          print('button pressed :.');
        },
      ),
      CalculatorButton(
        text: '00',
        textColor: Colors.black,
        onPressed: () {
          print('button pressed :00');
        },
      ),
      CalculatorButton(
        text: '=',
        textColor: Colors.white,
        onPressed: () {
          print('button pressed :=');
        },
      ),
      // change to Container
      CalculatorButton(
        text: '',
        textColor: Colors.white,
        onPressed: () {},
      ),
    ];

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MainAppState>();
    final textSize = (MediaQuery.of(context).orientation == Orientation.portrait ? MediaQuery.of(context).size.width / 12: MediaQuery.of(context).size.width / 22);
    return Scaffold(
      backgroundColor: Colors.indigo[900],
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Calculator', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.indigo[300],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Column(
            children: <Widget>[
              Text(appState.equation, style: TextStyle(color: Colors.indigo[200], fontSize: textSize)),
              Text(appState.result, style: TextStyle(color: Colors.indigo[200],  fontSize: textSize)),
            ],
          ),
          const Spacer(),
          GridView.builder(
            shrinkWrap: true,
            itemCount: buttons.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              childAspectRatio: MediaQuery.of(context).size.width /
                (MediaQuery.of(context).size.height / 2.0),
            ), 
            padding: EdgeInsets.zero,
            itemBuilder: (BuildContext context, int index ) {
              if (index == buttons.length - 1) {
                return Container(
                  color: Colors.indigo[300],
                );
              }
              return calcButton(context, buttons[index].text, buttons[index].textColor, buttons[index].onPressed);
            },
          ),
        ])
    ); 
  }
}

class CalculatorButton {
  final String text;
  final Color textColor;
  final VoidCallback onPressed;

  CalculatorButton({
    required this.text,
    required this.textColor,
    required this.onPressed,
  });
}

Widget calcButton(BuildContext context, String buttonText, Color buttonColor, void Function()? buttonPressed) {
  return Center(
  child: RawMaterialButton(
    onPressed: buttonPressed,
    fillColor: Colors.indigo[300],
    constraints: const BoxConstraints.expand(),
    child: Text(buttonText, style: TextStyle(color: buttonColor, fontSize: 24)),
  )
);
}