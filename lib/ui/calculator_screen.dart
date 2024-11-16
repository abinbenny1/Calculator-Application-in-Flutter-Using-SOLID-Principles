import 'package:flutter/material.dart';
import '../logic/calculator_service.dart';

class CalculatorScreen extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback toggleTheme;

  const CalculatorScreen({
    required this.isDarkMode,
    required this.toggleTheme,
  });

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final CalculatorService _calculatorService = CalculatorService();
  String _display = '';
  String _currentOperation = '';
  double? _firstOperand;
  double? _secondOperand;

  void _onNumberPressed(String number) {
    setState(() {
      _display += number;
    });
  }

  void _onOperationPressed(String operation) {
    if (_display.isEmpty) return;

    setState(() {
      _firstOperand = double.tryParse(_display);
      _display = '';
      _currentOperation = operation;
    });
  }

  void _onEqualsPressed() {
    if (_display.isEmpty || _firstOperand == null) return;

    setState(() {
      _secondOperand = double.tryParse(_display);
      try {
        final result = _calculatorService.performOperation(
          _currentOperation,
          _firstOperand!,
          _secondOperand!,
        );
        _display = result.toString();
      } catch (e) {
        _display = 'Error';
      }
      _currentOperation = '';
      _firstOperand = null;
      _secondOperand = null;
    });
  }

  void _onClearPressed() {
    setState(() {
      _display = '';
      _currentOperation = '';
      _firstOperand = null;
      _secondOperand = null;
    });
  }

  Widget _buildButton(String label, Color color, VoidCallback onPressed) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        fixedSize: const Size(70, 70),
        shape: CircleBorder(),
      ),
      onPressed: onPressed,
      child: Text(
        label,
        style: TextStyle(
          fontSize: 35,
          fontWeight: FontWeight.bold,
          color: isDarkMode ? Colors.white : Colors.black,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
        actions: [
          Row(
            children: [
              Icon(
                widget.isDarkMode ? Icons.dark_mode : Icons.light_mode,
              ),
              Switch(
                value: widget.isDarkMode,
                onChanged: (value) => widget.toggleTheme(),
              ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Display
            Expanded(
              child: Container(
                alignment: Alignment.bottomRight,
                padding: const EdgeInsets.all(16.0),
                color: Colors.black12,
                child: Text(
                  _display.isEmpty ? '0' : _display,
                  style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Buttons
            GridView.count(
              crossAxisCount: 4,
              shrinkWrap: true,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
              children: [
                // Number buttons
                for (int i = 1; i <= 9; i++)
                  _buildButton(
                    i.toString(),
                    Colors.blue.shade300,
                        () => _onNumberPressed(i.toString()),
                  ),
                _buildButton(
                  '0',
                  Colors.blue.shade300,
                      () => _onNumberPressed('0'),
                ),

                // Operations
                _buildButton(
                  '+',
                  Colors.orange.shade300,
                      () => _onOperationPressed('add'),
                ),
                _buildButton(
                  '-',
                  Colors.orange.shade300,
                      () => _onOperationPressed('subtract'),
                ),
                _buildButton(
                  '*',
                  Colors.orange.shade300,
                      () => _onOperationPressed('multiply'),
                ),
                _buildButton(
                  '/',
                  Colors.orange.shade300,
                      () => _onOperationPressed('divide'),
                ),
                _buildButton(
                  '√',
                  Colors.orange.shade300,
                      () {
                    setState(() {
                      if (_display.isNotEmpty) {
                        try {
                          final result = _calculatorService.performOperation(
                              'sqrt', double.parse(_display), 0);
                          _display = result.toString();
                        } catch (e) {
                          _display = 'Error';
                        }
                      }
                    });
                  },
                ),
                _buildButton(
                  'C',
                  Colors.red.shade300,
                  _onClearPressed,
                ),
                _buildButton(
                  '=',
                  Colors.green.shade300,
                  _onEqualsPressed,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
