// import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_notes_app/utils/calculator_logic.dart';
import '../widgets/calculator_button.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _displayText = '0';

  void _onButtonPressed(String value) {
    setState(() {
      final operators = ['+', '-', '×', '÷'];

      if (_displayText == 'Error' || _displayText == '0') {
        if (!operators.contains(value)) {
          _displayText = value;
          return;
        } else {
          return;
        }
      }

      if (operators.contains(value)) {
        if (_displayText.isNotEmpty &&
            operators.contains(_displayText[_displayText.length - 1])) {
          _displayText =
              _displayText.substring(0, _displayText.length - 1) + value;
        } else if (_displayText.isNotEmpty) {
          _displayText += value;
        }
      } else {
        _displayText += value;
      }
    });
  }

  void _calculateResult() {
    try {
      // 不要な「＝【イコール）があれば取り除く
      String expression = _displayText.replaceAll('=', '');
      double reslut = calculate(expression);
      setState(() {
        _displayText = reslut.toString();
      });
    } catch (e) {
      setState(() {
        _displayText = 'Error';
      });
    }
  }

  void _clear() {
    setState(() {
      _displayText = '0';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calculator')),
      body: Column(
        children: [
          // 結果表示エリア
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.all(24),
              child: Text(
                _displayText,
                style: const TextStyle(fontSize: 48),
              ),
            ),
          ),
          // キーパッドエリア
          Container(
            color: Colors.grey[200],
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CalculatorButton(text: '7', onTap: _onButtonPressed),
                    CalculatorButton(text: '8', onTap: _onButtonPressed),
                    CalculatorButton(text: '9', onTap: _onButtonPressed),
                    CalculatorButton(text: '÷', onTap: _onButtonPressed),
                  ],
                ),
                // 他の行も同様に作成（数字、演算子、AC、＝など）
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CalculatorButton(text: '4', onTap: _onButtonPressed),
                    CalculatorButton(text: '5', onTap: _onButtonPressed),
                    CalculatorButton(text: '6', onTap: _onButtonPressed),
                    CalculatorButton(text: '×', onTap: _onButtonPressed),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CalculatorButton(text: '1', onTap: _onButtonPressed),
                    CalculatorButton(text: '2', onTap: _onButtonPressed),
                    CalculatorButton(text: '3', onTap: _onButtonPressed),
                    CalculatorButton(text: '-', onTap: _onButtonPressed),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CalculatorButton(text: '0', onTap: _onButtonPressed),
                    CalculatorButton(text: 'AC', onTap: (_) => _clear()),
                    CalculatorButton(
                        text: '=', onTap: (_) => _calculateResult()),
                    CalculatorButton(text: '+', onTap: _onButtonPressed),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
