import 'package:flutter/material.dart';

void main() => runApp(CalculatorApp());

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CalculatorHomePage(),
    );
  }
}

class CalculatorHomePage extends StatefulWidget {
  @override
  _CalculatorHomePageState createState() => _CalculatorHomePageState();
}

class _CalculatorHomePageState extends State<CalculatorHomePage> {
  String _displayValue = '0';
  double _num1;
  double _num2;
  String _operation;

  void _onPressed(String text) {
    setState(() {
      switch (text) {
        case 'C':
          _displayValue = '0';
          _num1 = null;
          _num2 = null;
          _operation = null;
          break;
        case '+/-':
          if (_displayValue.contains('-')) {
            _displayValue = _displayValue.substring(1);
          } else {
            _displayValue = '-' + _displayValue;
          }
          break;
        case '%':
          double val = double.parse(_displayValue);
          _displayValue = (val / 100).toString();
          break;
        case '/':
        case 'X':
        case '-':
        case '+':
          _num1 = double.parse(_displayValue);
          _operation = text;
          _displayValue = '0';
          break;
        case '.':
          if (!_displayValue.contains('.')) {
            _displayValue += '.';
          }
          break;
        case '=':
          if (_num1 != null && _num2 != null && _operation != null) {
            switch (_operation) {
              case '/':
                _displayValue = (_num1 / _num2).toString();
                break;
              case 'X':
                _displayValue = (_num1 * _num2).toString();
                break;
              case '-':
                _displayValue = (_num1 - _num2).toString();
                break;
              case '+':
                _displayValue = (_num1 + _num2).toString();
                break;
            }
            _num1 = double.parse(_displayValue);
            _num2 = null;
            _operation = null;
          }
          break;
        default:
          if (_displayValue == '0') {
            _displayValue = text;
          } else {
            _displayValue += text;
          }
          break;
      }
    });
  }

  Widget _buildButton(String text) {
    return Expanded(
      child: OutlineButton(
        padding: EdgeInsets.all(24.0),
        child: Text(
          text,
          style: TextStyle(fontSize: 20.0),
        ),
        onPressed: () => _onPressed(text),
      ),
    );
  }

  Widget _buildRow(String text1, String text2, String text3, String text4) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildButton(text1),
          _buildButton(text2),
          _buildButton(text3),
          _buildButton(text4),
        ],
      ),
    );
  }

  @overrideWidget
