import 'dart:math';
import 'package:math_expressions/math_expressions.dart';

double calculate(String expression) {
  try {
    expression = expression.replaceAll('×', '*').replaceAll('÷', '/');
    Parser p = Parser();
    Expression exp = p.parse(expression);
    ContextModel cm = ContextModel();
    double result = exp.evaluate(EvaluationType.REAL, cm);

    // 10%の確率でふざける
    Random rand = Random();
    int chance = rand.nextInt(10);
    if (chance == 0) {
      return result + rand.nextInt(5) + 1; // +1〜+5ぐらいズレる
    }

    return result;
  } catch (e) {
    throw Exception('Invalid expression');
  }
}
