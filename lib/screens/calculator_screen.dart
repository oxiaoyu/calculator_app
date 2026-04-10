import 'package:flutter/material.dart';
import '../theme/candy_colors.dart';
import '../utils/calculator_logic.dart';
import '../widgets/calculator_button.dart';
import '../widgets/display.dart';

/// Main calculator screen
class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final CalculatorLogic _logic = CalculatorLogic();

  String get _displayValue => _logic.displayValue;
  String get _expression => _logic.expression;

  void _onButtonPressed(String key) {
    setState(() {
      _logic.input(key);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CandyColors.mainBg,
      body: SafeArea(
        child: Column(
          children: [
            // Display area (35%)
            Expanded(
              flex: 35,
              child: CalculatorDisplay(
                value: _displayValue,
                expression: _expression,
              ),
            ),

            // Button area (65%)
            Expanded(
              flex: 65,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    // Row 1: AC, +/-, %, ÷
                    Expanded(
                      child: Row(
                        children: [
                          CalculatorButton(
                            label: 'AC',
                            type: ButtonType.function,
                            onPressed: () => _onButtonPressed('AC'),
                          ),
                          CalculatorButton(
                            label: '+/-',
                            type: ButtonType.function,
                            onPressed: () => _onButtonPressed('+/-'),
                          ),
                          CalculatorButton(
                            label: '%',
                            type: ButtonType.function,
                            onPressed: () => _onButtonPressed('%'),
                          ),
                          CalculatorButton(
                            label: '÷',
                            type: ButtonType.operator,
                            onPressed: () => _onButtonPressed('÷'),
                          ),
                        ],
                      ),
                    ),

                    // Row 2: 7, 8, 9, ×
                    Expanded(
                      child: Row(
                        children: [
                          CalculatorButton(
                            label: '7',
                            type: ButtonType.number,
                            onPressed: () => _onButtonPressed('7'),
                          ),
                          CalculatorButton(
                            label: '8',
                            type: ButtonType.number,
                            onPressed: () => _onButtonPressed('8'),
                          ),
                          CalculatorButton(
                            label: '9',
                            type: ButtonType.number,
                            onPressed: () => _onButtonPressed('9'),
                          ),
                          CalculatorButton(
                            label: '×',
                            type: ButtonType.operator,
                            onPressed: () => _onButtonPressed('×'),
                          ),
                        ],
                      ),
                    ),

                    // Row 3: 4, 5, 6, -
                    Expanded(
                      child: Row(
                        children: [
                          CalculatorButton(
                            label: '4',
                            type: ButtonType.number,
                            onPressed: () => _onButtonPressed('4'),
                          ),
                          CalculatorButton(
                            label: '5',
                            type: ButtonType.number,
                            onPressed: () => _onButtonPressed('5'),
                          ),
                          CalculatorButton(
                            label: '6',
                            type: ButtonType.number,
                            onPressed: () => _onButtonPressed('6'),
                          ),
                          CalculatorButton(
                            label: '-',
                            type: ButtonType.operator,
                            onPressed: () => _onButtonPressed('-'),
                          ),
                        ],
                      ),
                    ),

                    // Row 4: 1, 2, 3, +
                    Expanded(
                      child: Row(
                        children: [
                          CalculatorButton(
                            label: '1',
                            type: ButtonType.number,
                            onPressed: () => _onButtonPressed('1'),
                          ),
                          CalculatorButton(
                            label: '2',
                            type: ButtonType.number,
                            onPressed: () => _onButtonPressed('2'),
                          ),
                          CalculatorButton(
                            label: '3',
                            type: ButtonType.number,
                            onPressed: () => _onButtonPressed('3'),
                          ),
                          CalculatorButton(
                            label: '+',
                            type: ButtonType.operator,
                            onPressed: () => _onButtonPressed('+'),
                          ),
                        ],
                      ),
                    ),

                    // Row 5: 0 (wide), ., =
                    Expanded(
                      child: Row(
                        children: [
                          // 0 button takes 2 columns
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(6),
                              child: GestureDetector(
                                onTap: () => _onButtonPressed('0'),
                                child: Container(
                                  height: 64,
                                  decoration: BoxDecoration(
                                    color: CandyColors.numberButtonBg,
                                    borderRadius: BorderRadius.circular(16),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        offset: const Offset(0, 2),
                                        blurRadius: 4,
                                      ),
                                    ],
                                  ),
                                  child: const Center(
                                    child: Text(
                                      '0',
                                      style: TextStyle(
                                        color: CandyColors.numberButtonText,
                                        fontSize: 28,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          CalculatorButton(
                            label: '.',
                            type: ButtonType.number,
                            fontSize: 28,
                            onPressed: () => _onButtonPressed('.'),
                          ),
                          CalculatorButton(
                            label: '=',
                            type: ButtonType.equals,
                            onPressed: () => _onButtonPressed('='),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
