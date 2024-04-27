import 'dart:math';

import 'package:calculator_proj/numpad.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MainApp());
}

class MainAppState extends ChangeNotifier {
  String equation = "0";
  String resultText = "0";
  double result = 0.0;

  bool _isFirstInput() {
    return equation == "0";
  }

  bool _isPointAlready(String text, String equation) {
    return (text == "." && equation.contains("."));
  }

  bool _includeOperator() {
    return equation.contains("+") ||
        equation.contains("-") ||
        equation.contains("×") ||
        equation.contains("/");
  }

  int _getLastOperatorIndex() {
    // equationの最後から走査して最初に+ or - or x or /が見つかったindexを取得
    int operatorIndex = equation.lastIndexOf("+");
    operatorIndex =
        operatorIndex == -1 ? equation.lastIndexOf("-") : operatorIndex;
    operatorIndex =
        operatorIndex == -1 ? equation.lastIndexOf("×") : operatorIndex;
    operatorIndex =
        operatorIndex == -1 ? equation.lastIndexOf("/") : operatorIndex;
    return operatorIndex;
  }

  void initialize() {
    equation = "0";
    resultText = "0";
    result = 0.0;
    notifyListeners();
  }

  int _skipExponentIndexOf(String s) {
    // +の前にeがある場合、+は演算子ではないのでスキップ

    for (int i = 0; i < equation.length; i++) {
      if (equation[i] == s) {
        if (i == 0 || equation[i - 1] != "e") {
          return i;
        }
      }
    }
    return -1;
  }

  void calculateEquation() {
    bool endWithOperator = equation.endsWith("+") ||
        equation.endsWith("-") ||
        equation.endsWith("×") ||
        equation.endsWith("/");

    if (equation.length > 20) {
      equation = "0";
      resultText = "Error";
      result = 0.0;
      return;
    }

    // 電卓アルゴリズム 乗算・除算を優先して計算
    // 1. 乗算・除算のindexを取得
    // 2. 乗算・除算のindexが見つかった場合、その前後の数値を計算して置換
    // 3. 乗算・除算のindexが見つからなくなるまで繰り返す
    // 4. 足し算・引き算を計算
    String equationtemp = equation;
    while (equation.contains("×") || equation.contains("/")) {
      int index = equation.contains("×") == false
          ? equation.indexOf("/")
          : equation.indexOf("×");
      int leftIndex = index - 1;
      int rightIndex = index + 1;
      while (leftIndex > 0 &&
          equation[leftIndex] != "+" &&
          equation[leftIndex] != "-") {
        leftIndex--;
      }
      while (rightIndex < equation.length &&
          equation[rightIndex] != "+" &&
          equation[rightIndex] != "-") {
        rightIndex++;
      }
      double left = double.parse(equation.substring(leftIndex + 1, index));
      double right = double.parse(equation.substring(index + 1, rightIndex));
      double result = equation[index] == "×" ? left * right : left / right;
      equation = equation.substring(0, leftIndex + 1) +
          result.toString() +
          equation.substring(rightIndex);
    }
    int plusIndex = _skipExponentIndexOf("+");
    int minusIndex = _skipExponentIndexOf("-");
    while (plusIndex != -1 || minusIndex != -1) {
      int index;
      if (plusIndex == -1) {
        index = minusIndex;
      } else if (minusIndex == -1) {
        index = plusIndex;
      } else {
        index = min(plusIndex, minusIndex);
      }

      int leftIndex = index - 1;
      int rightIndex = index + 1;
      while (leftIndex > 0 &&
          equation[leftIndex] != "+" &&
          equation[leftIndex] != "-") {
        // +の前にeがある場合、+は演算子ではないのでスキップ
        leftIndex--;
      }
      while (rightIndex < equation.length &&
          equation[rightIndex] != "+" &&
          equation[rightIndex] != "-") {
        rightIndex++;
      }
      if (leftIndex == 0) {
        leftIndex--;
      }

      double left = double.parse(equation.substring(leftIndex + 1, index));

      double right = double.parse(equation.substring(index + 1, rightIndex));
      double result = equation[index] == "+" ? left + right : left - right;

      equation = equation.substring(0, leftIndex + 1) +
          result.toString() +
          equation.substring(rightIndex);
      plusIndex = _skipExponentIndexOf("+");
      minusIndex = _skipExponentIndexOf("-");
    }
    // .00の場合、.を削除
    if (equation.endsWith(".0")) {
      equation = equation.substring(0, equation.length - 2);
    }
    resultText = equation;
    equation = equationtemp;

    if (equation == "Infinity") {
      resultText = "0";
      result = 0.0;
      return;
    }
    result = double.parse(resultText);
  }

  void numClick(String text) {
    // validate point
    int operatorIndex = _getLastOperatorIndex();
    if (operatorIndex == -1) {
      if (_isPointAlready(text, equation)) {
        return;
      }
    } else {
      // operatorIndexの次の文字から最後までを取得
      String lastInput = equation.substring(operatorIndex + 1);
      if (_isPointAlready(text, lastInput)) {
        return;
      }
    }

    // validate first input
    if (_isFirstInput()) {
      if (text == "00" || text == ".") {
        return;
      }
      equation = text;
      result = double.parse(text);
      notifyListeners();
      return;
    }
    equation += text;
    calculateEquation();
    notifyListeners();
  }

  void operatorClick(String text) {
    switch (text) {
      case "+":
      case "-":
      case "×":
      case "/":
        if (_isFirstInput()) {
          return;
        }
        if (equation.endsWith("+") ||
            equation.endsWith("-") ||
            equation.endsWith("×") ||
            equation.endsWith("/")) {
          equation = equation.substring(0, equation.length - 1) + text;
          break;
        }
        equation += text;
        break;
      case "=":
        if (_isFirstInput() ||
            equation.endsWith("+") ||
            equation.endsWith("-") ||
            equation.endsWith("×") ||
            equation.endsWith("/")) {
          return;
        }
        equation = result.toString();
        resultText = "0";
        break;
      case "C":
        equation = "0";
        break;
      case "AC":
        initialize();
        break;
    }
    notifyListeners();
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MainAppState(),
      child: MaterialApp(
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
