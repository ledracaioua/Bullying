import 'package:flutter/material.dart';
import '../../core/routes/app_routes.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _expression = '';
  String _result = '';
  int _equalPressCount = 0;

  void _onPressed(String value) {
    setState(() {
      if (value == 'C') {
        _expression = '';
        _result = '';
        _equalPressCount = 0;
      } else if (value == '=') {
        _equalPressCount++;
        if (_equalPressCount >= 5) {
          Navigator.pushNamed(context, AppRoutes.emergency);
          _equalPressCount = 0;
        } else {
          try {
            final parsedExpression = _expression
                .replaceAll('×', '*')
                .replaceAll('÷', '/');

            final double eval = _evaluateExpression(parsedExpression);
            _result = eval.toString();
          } catch (_) {
            _result = 'Error';
          }
        }
      } else {
        _expression += value;
        _equalPressCount =
            0; // reiniciar o contador se outro botão for pressionado
      }
    });
  }

  double _evaluateExpression(String expr) {
    // Cálculo básico seguro com RegExp
    final operators = RegExp(r'[-+*/]');
    final parts = expr.split(operators);
    final operatorMatch = operators.firstMatch(expr);

    if (parts.length < 2 || operatorMatch == null) return double.parse(expr);

    final num1 = double.tryParse(parts[0].trim()) ?? 0;
    final num2 = double.tryParse(parts[1].trim()) ?? 0;
    final op = operatorMatch.group(0);

    switch (op) {
      case '+':
        return num1 + num2;
      case '-':
        return num1 - num2;
      case '*':
        return num1 * num2;
      case '/':
        return num2 != 0 ? num1 / num2 : double.nan;
      default:
        return 0;
    }
  }

  Widget _buildButton(String text, Color color) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: ElevatedButton(
          onPressed: () => _onPressed(text),
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 22),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          child: Text(
            text,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Calculadora')),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              alignment: Alignment.bottomRight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    _expression,
                    style: const TextStyle(fontSize: 28, color: Colors.black54),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _result,
                    style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Column(
            children: [
              Row(
                children: [
                  _buildButton('7', theme.primaryContainer),
                  _buildButton('8', theme.primaryContainer),
                  _buildButton('9', theme.primaryContainer),
                  _buildButton('÷', theme.secondary),
                ],
              ),
              Row(
                children: [
                  _buildButton('4', theme.primaryContainer),
                  _buildButton('5', theme.primaryContainer),
                  _buildButton('6', theme.primaryContainer),
                  _buildButton('×', theme.secondary),
                ],
              ),
              Row(
                children: [
                  _buildButton('1', theme.primaryContainer),
                  _buildButton('2', theme.primaryContainer),
                  _buildButton('3', theme.primaryContainer),
                  _buildButton('-', theme.secondary),
                ],
              ),
              Row(
                children: [
                  _buildButton('0', theme.primaryContainer),
                  _buildButton('C', Colors.red),
                  _buildButton('=', theme.primary),
                  _buildButton('+', theme.secondary),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
