import 'dart:math';
import 'package:flutter/material.dart';

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
    int plusIndex = equation.lastIndexOf("+");
    int minusIndex = equation.lastIndexOf("-");
    int multiplyIndex = equation.lastIndexOf("×");
    int divideIndex = equation.lastIndexOf("/");
    int operatorIndex =
        max(plusIndex, max(minusIndex, max(multiplyIndex, divideIndex)));
    return operatorIndex;
  }

  void initialize() {
    equation = "0";
    resultText = "0";
    result = 0.0;
    notifyListeners();
  }

  int _skipExponentIndexOf(String s) {
    // skip "e+", "e-", "+-", "--", "x-", "/-"

    for (int i = 0; i < equation.length; i++) {
      if (equation[i] == s) {
        if (i > 0 &&
            (equation[i - 1] != "e" &&
                equation[i - 1] != "+" &&
                equation[i - 1] != "-" &&
                equation[i - 1] != "×" &&
                equation[i - 1] != "/")) {
          return i;
        }
      }
    }
    return -1;
  }

  void calculateEquation() {
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
      int multiplyIndex = equation.indexOf("×");
      int divideIndex = equation.indexOf("/");
      int index;
      if (multiplyIndex == -1) {
        index = divideIndex;
      } else if (divideIndex == -1) {
        index = multiplyIndex;
      } else {
        index = min(multiplyIndex, divideIndex);
      }

      int leftIndex = index - 1;
      int rightIndex = index + 1;
      while (leftIndex > 0 &&
          equation[leftIndex] != "+" &&
          (equation[leftIndex] != "-" &&
              (equation[leftIndex - 1] != "e" ||
                  equation[leftIndex - 1] != "+" ||
                  equation[leftIndex - 1] != "×" ||
                  equation[leftIndex - 1] != "/"))) {
        leftIndex--;
      }
      while (rightIndex < equation.length &&
          (equation[rightIndex] != "+" &&
              (equation[rightIndex] != "-" ||
                  (equation[rightIndex] == "-" &&
                      (equation[rightIndex - 1] == "e" ||
                          equation[rightIndex - 1] == "+" ||
                          equation[rightIndex - 1] == "-" ||
                          equation[rightIndex - 1] == "×" ||
                          equation[rightIndex - 1] ==
                              "/"))) // -の後ろにoperatorがある場合はスキップ
              &&
              equation[rightIndex] != "×" &&
              equation[rightIndex] != "/")) {
        rightIndex++;
      }
      if (leftIndex == 0) {
        leftIndex--;
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
          (equation[leftIndex] != "-" &&
              (equation[leftIndex - 1] != "e" ||
                  equation[leftIndex - 1] != "+" ||
                  equation[leftIndex - 1] != "×" ||
                  equation[leftIndex - 1] != "/"))) {
        // +の前にeがある場合、+は演算子ではないのでスキップ
        leftIndex--;
      }
      while (rightIndex < equation.length &&
          (equation[rightIndex] != "+" &&
              (equation[rightIndex] != "-" ||
                  (equation[rightIndex] == "-" &&
                      (equation[rightIndex - 1] == "e" ||
                          equation[rightIndex - 1] == "+" ||
                          equation[rightIndex - 1] == "-" ||
                          equation[rightIndex - 1] == "×" ||
                          equation[rightIndex - 1] ==
                              "/") // -の後ろにoperatorがある場合はスキップ
                  )) &&
              equation[rightIndex] != "×" &&
              equation[rightIndex] != "/")) {
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

    if (equation.contains("Infinity")) {
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
      if (text == "00") {
        return;
      }
      if (text == ".") {
        equation = "0.";
        resultText = "0.";
        notifyListeners();
        return;
      }
      equation = text;
      result = double.parse(text);
      notifyListeners();
      return;
    }
    equation += text;
    if (_includeOperator()) {
      calculateEquation();
    }
    notifyListeners();
  }

  void operatorClick(String text) {
    switch (text) {
      case "+":
      case "-":
      case "×":
      case "/":
        bool isMinus = text == "-";
        if (!isMinus && _isFirstInput()) {
          return;
        }
        if (isMinus) {
          if (equation.endsWith("-")) {
            return;
          }
          if (equation.endsWith("+") ||
              equation.endsWith("×") ||
              equation.endsWith("/")) {
            equation = equation + text;
            break;
          }
        } else if (equation.endsWith("+") ||
            equation.endsWith("-") ||
            equation.endsWith("×") ||
            equation.endsWith("/")) {
          equation = equation.substring(0, equation.length - 1) + text;
          break;
        }
        if (isMinus && _isFirstInput()) {
          equation = text;
        } else {
          equation += text;
        }
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
        if (equation.endsWith(".0")) {
          equation = equation.substring(0, equation.length - 2);
        }
        resultText = "0";
        break;
      case "C":
        equation = resultText;
        break;
      case "AC":
        initialize();
        break;
    }
    notifyListeners();
  }
}

// test
// 1 + 2 * 3 - 5 / 2 = 4.5
// 1 + 2
// 10 - 5
// 3.5 * 4
// 20 / 4
// 1 / 0 = Infinity
// -10 + 5
// 3 * (-4)
// 2 + 3 * 4 - 6 / 3
// 5.2 + -3.7 * 2.1        = -2.57
// -10 / 2 + 3.5 * -4      = -19
// 100.5 - 25.25 * 2 + 6.5 = 56.5
// -0.2 * -0.4 / 5 + 3.1   = 3.116
// 15 / 3 - 2.5 * -1.2     = 8
// -6.6 + 2.2 * 3 - 4 / -2 = 2 NG
// 50 / -5 + 7.7 - 4.4     = -6.7
// -12.5 * 0.8 + 6 / 3     = -8
// 25.25 / 5 - 3.3 * 1.5   = 0.1
// -0.75 * -20 + 8 / 4     = 17