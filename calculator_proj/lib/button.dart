import 'package:flutter/material.dart';

enum ButtonType { num, operator }

class CalculatorButton {
  final String text;
  final Color textColor;
  final ButtonType buttonType;
  final VoidCallback onPressed;

  CalculatorButton({
    required this.text,
    required this.textColor,
    required this.buttonType,
    required this.onPressed,
  });
}

final buttons = [
  CalculatorButton(
    text: '7',
    textColor: Colors.black,
    buttonType: ButtonType.num,
    onPressed: () {
      print('button pressed :7');
    },
  ),
  CalculatorButton(
    text: '8',
    textColor: Colors.black,
    buttonType: ButtonType.num,
    onPressed: () {
      print('button pressed :8');
    },
  ),
  CalculatorButton(
    text: '9',
    textColor: Colors.black,
    buttonType: ButtonType.num,
    onPressed: () {
      print('button pressed :9');
    },
  ),
  CalculatorButton(
    text: 'C',
    textColor: Colors.red,
    buttonType: ButtonType.operator,
    onPressed: () {
      print('button pressed :C');
    },
  ),
  CalculatorButton(
    text: 'AC',
    textColor: Colors.red,
    buttonType: ButtonType.operator,
    onPressed: () {
      print('button pressed :AC');
    },
  ),
  CalculatorButton(
    text: '4',
    textColor: Colors.black,
    buttonType: ButtonType.num,
    onPressed: () {
      print('button pressed :4');
    },
  ),
  CalculatorButton(
    text: '5',
    textColor: Colors.black,
    buttonType: ButtonType.num,
    onPressed: () {
      print('button pressed :5');
    },
  ),
  CalculatorButton(
    text: '6',
    textColor: Colors.black,
    buttonType: ButtonType.num,
    onPressed: () {
      print('button pressed :6');
    },
  ),
  CalculatorButton(
    text: '+',
    textColor: Colors.white,
    buttonType: ButtonType.operator,
    onPressed: () {
      print('button pressed :+');
    },
  ),
  // - minus button
  CalculatorButton(
    text: '-',
    textColor: Colors.white,
    buttonType: ButtonType.operator,
    onPressed: () {
      print('button pressed :-');
    },
  ),
  CalculatorButton(
    text: '1',
    textColor: Colors.black,
    buttonType: ButtonType.num,
    onPressed: () {
      print('button pressed :1');
    },
  ),
  CalculatorButton(
    text: '2',
    textColor: Colors.black,
    buttonType: ButtonType.num,
    onPressed: () {
      print('button pressed :2');
    },
  ),
  CalculatorButton(
    text: '3',
    textColor: Colors.black,
    buttonType: ButtonType.num,
    onPressed: () {
      print('button pressed :3');
    },
  ),
  CalculatorButton(
    text: '×',
    textColor: Colors.white,
    buttonType: ButtonType.operator,
    onPressed: () {
      print('button pressed :×');
    },
  ),
  CalculatorButton(
    text: '/',
    textColor: Colors.white,
    buttonType: ButtonType.operator,
    onPressed: () {
      print('button pressed :/');
    },
  ),
  CalculatorButton(
    text: '0',
    textColor: Colors.black,
    buttonType: ButtonType.num,
    onPressed: () {
      print('button pressed :0');
    },
  ),
  CalculatorButton(
    text: '.',
    textColor: Colors.black,
    buttonType: ButtonType.num,
    onPressed: () {
      print('button pressed :.');
    },
  ),
  CalculatorButton(
    text: '00',
    textColor: Colors.black,
    buttonType: ButtonType.num,
    onPressed: () {
      print('button pressed :00');
    },
  ),
  CalculatorButton(
    text: '=',
    textColor: Colors.white,
    buttonType: ButtonType.operator,
    onPressed: () {
      print('button pressed :=');
    },
  ),
  // change to Container
  CalculatorButton(
    text: '',
    textColor: Colors.white,
    buttonType: ButtonType.operator,
    onPressed: () {},
  ),
];
