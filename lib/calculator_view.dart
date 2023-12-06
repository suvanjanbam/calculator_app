import 'dart:math' as math;

import 'package:flutter/material.dart';

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});

  @override
  _CalculatorAppState createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  String _output = '0';
  String _currentInput = '';
  double _num1 = 0;
  String _operator = '';
  String _operatorText = '';

  void _onButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        _clear();
        _operatorText = '';
      } else if ('+-*/%'.contains(buttonText)) {
        _performOperation(buttonText);
        _operatorText = buttonText;
      } else if (buttonText == '=') {
        _calculateResult();
        _operatorText = '';
      } else if (buttonText == '<-') {
        _backspace();
      } else if (buttonText == '√') {
        _performOperation(buttonText);
      } else {
        _updateInput(buttonText);
        _operatorText = '';
      }
    });
  }

  void _clear() {
    _output = '0';
    _currentInput = '';
    _num1 = 0;
    _operator = '';
  }

  void _performOperation(String operator) {
    if (_currentInput.isNotEmpty) {
      if (operator == '√') {
        // Square root operation
        double num = double.parse(_currentInput);
        _output = (num >= 0) ? math.sqrt(num).toString() : 'Error';
        _currentInput = _output;
      } else {
        _num1 = double.parse(_currentInput);
        _currentInput = '';
        _operator = operator;
      }
    }
  }

  void _updateInput(String value) {
    if (_currentInput.length < 10) {
      _currentInput += value;
      _output = _currentInput;
    }
  }

  void _backspace() {
    setState(() {
      if (_currentInput.isNotEmpty) {
        _currentInput = _currentInput.substring(0, _currentInput.length - 1);
        _output = _currentInput.isEmpty ? '0' : _currentInput;
      }
    });
  }

  void _calculateResult() {
    if (_currentInput.isNotEmpty && _operator.isNotEmpty) {
      double num2 = double.parse(_currentInput);
      switch (_operator) {
        case '+':
          _output = (_num1 + num2).toString();
          break;
        case '-':
          _output = (_num1 - num2).toString();
          break;
        case '*':
          _output = (_num1 * num2).toString();
          break;
        case '/':
          _output = (num2 != 0) ? (_num1 / num2).toString() : 'Error';
          break;
        case '%':
          _output = (num2 != 0) ? (_num1 % num2).toString() : 'Error';
          break;
      }
      _currentInput = '';
      _operator = '';
      _num1 = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<List<String>> buttonRows = [
      [
        'C',
        '*',
        '/',
        '<-',
      ],
      [
        '1',
        '2',
        '3',
        '+',
      ],
      [
        '4',
        '5',
        '6',
        '-',
      ],
      [
        '7',
        '8',
        '9',
        '%',
      ],
      ['0', '.', '=', '√']
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.bottomRight,
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10)),
            child: Text(
              _output,
              style: const TextStyle(fontSize: 40),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: GridView.count(
              padding: const EdgeInsets.all(8),
              crossAxisCount: 4,
              crossAxisSpacing: 9.0,
              mainAxisSpacing: 42.0,
              children: [
                for (int row = 0; row < buttonRows.length; row++)
                  for (int col = 0; col < buttonRows[row].length; col++)
                    Expanded(
                      child: FractionallySizedBox(
                        heightFactor: 1.35,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey.shade300,
                          ),
                          onPressed: () =>
                              _onButtonPressed(buttonRows[row][col]),
                          child: Text(
                            buttonRows[row][col],
                            style: const TextStyle(
                                fontSize: 30, color: Colors.black),
                          ),
                        ),
                      ),
                    ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
