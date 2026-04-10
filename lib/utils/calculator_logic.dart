/// Calculator logic implementation
/// Standard calculator mode: evaluates left-to-right (ignores mathematical precedence)
class CalculatorLogic {
  String _displayValue = '0';
  String _firstOperand = '';
  String _operator = '';
  String _secondOperand = '';
  bool _shouldResetDisplay = false;
  bool _hasError = false;
  String? _lastOperator;
  String? _lastSecondOperand;

  /// Get current display value
  String get displayValue => _displayValue;

  /// Get expression for display (e.g., "5 + 3")
  String get expression {
    if (_firstOperand.isEmpty) return '';
    if (_operator.isEmpty) return _firstOperand;
    if (_secondOperand.isEmpty) return '$_firstOperand $_operator';
    return '$_firstOperand $_operator $_secondOperand';
  }

  /// Input a key and return new display value
  String input(String key) {
    if (_hasError && key != 'AC') {
      return _displayValue;
    }

    switch (key) {
      case 'AC':
        return _clear();
      case '⌫':
        return _backspace();
      case '+/-':
        return _toggleSign();
      case '%':
        return _percentage();
      case '+':
      case '-':
      case '×':
      case '÷':
        return _setOperator(key);
      case '=':
        return _calculate();
      case '.':
        return _inputDecimal();
      default:
        // Number keys (0-9)
        return _inputNumber(key);
    }
  }

  String _clear() {
    _displayValue = '0';
    _firstOperand = '';
    _operator = '';
    _secondOperand = '';
    _shouldResetDisplay = false;
    _hasError = false;
    _lastOperator = null;
    _lastSecondOperand = null;
    return _displayValue;
  }

  String _backspace() {
    if (_shouldResetDisplay || _hasError) {
      return _displayValue;
    }

    if (_secondOperand.isNotEmpty) {
      _secondOperand = _secondOperand.substring(0, _secondOperand.length - 1);
      _displayValue = _secondOperand.isEmpty ? '0' : _secondOperand;
    } else if (_operator.isNotEmpty) {
      _operator = '';
      _displayValue = _firstOperand;
    } else if (_firstOperand.length > 1) {
      _firstOperand = _firstOperand.substring(0, _firstOperand.length - 1);
      _displayValue = _firstOperand;
    } else {
      _firstOperand = '';
      _displayValue = '0';
    }
    return _displayValue;
  }

  String _toggleSign() {
    if (_hasError) return _displayValue;

    if (_secondOperand.isNotEmpty) {
      _secondOperand = _formatNumber(-double.parse(_secondOperand));
      _displayValue = _secondOperand;
    } else if (_firstOperand.isNotEmpty) {
      _firstOperand = _formatNumber(-double.parse(_firstOperand));
      _displayValue = _firstOperand;
    }
    return _displayValue;
  }

  String _percentage() {
    if (_hasError) return _displayValue;

    double value = 0;
    if (_secondOperand.isNotEmpty) {
      value = double.parse(_secondOperand);
      _secondOperand = _formatNumber(value / 100);
      _displayValue = _secondOperand;
    } else if (_firstOperand.isNotEmpty) {
      value = double.parse(_firstOperand);
      _firstOperand = _formatNumber(value / 100);
      _displayValue = _firstOperand;
    }
    return _displayValue;
  }

  String _setOperator(String op) {
    if (_hasError) return _displayValue;

    if (_secondOperand.isNotEmpty) {
      // Chain calculation: evaluate current expression first
      _calculate();
    }

    _operator = op;
    _shouldResetDisplay = true;
    return _displayValue;
  }

  String _inputDecimal() {
    if (_hasError) return _displayValue;

    String currentValue;
    if (_operator.isEmpty) {
      currentValue = _firstOperand;
    } else {
      currentValue = _secondOperand;
    }

    // Check if already has decimal point
    if (currentValue.contains('.')) {
      return _displayValue;
    }

    if (currentValue.isEmpty || _shouldResetDisplay) {
      currentValue = '0.';
    } else {
      currentValue = '$currentValue.';
    }

    if (_operator.isEmpty) {
      _firstOperand = currentValue;
    } else {
      _secondOperand = currentValue;
    }

    _displayValue = currentValue;
    _shouldResetDisplay = false;
    return _displayValue;
  }

  String _inputNumber(String digit) {
    if (_hasError) return _displayValue;

    // Check max digits (15 for integer part)
    String currentValue;
    bool isFirstPart = _operator.isEmpty;

    if (isFirstPart) {
      currentValue = _firstOperand;
    } else {
      currentValue = _secondOperand;
    }

    // If decimal point exists, check decimal places (max 8)
    if (currentValue.contains('.')) {
      final parts = currentValue.split('.');
      if (parts[1].length >= 8) {
        return _displayValue;
      }
    } else {
      // Check integer part length (max 15)
      final numStr = currentValue.replaceAll('-', '');
      if (numStr.length >= 15) {
        return _displayValue;
      }
    }

    if (_shouldResetDisplay || currentValue == '0') {
      currentValue = digit;
      _shouldResetDisplay = false;
    } else {
      // Check total length including new digit
      if (currentValue.replaceAll('-', '').length >= 15) {
        return _displayValue;
      }
      currentValue = '$currentValue$digit';
    }

    if (isFirstPart) {
      _firstOperand = currentValue;
    } else {
      _secondOperand = currentValue;
    }

    _displayValue = currentValue;
    return _displayValue;
  }

  String _calculate() {
    if (_operator.isEmpty || _secondOperand.isEmpty) {
      // Continuous equals: repeat last operation
      if (_lastOperator != null && _lastSecondOperand != null) {
        _firstOperand = _displayValue;
        _operator = _lastOperator!;
        _secondOperand = _lastSecondOperand!;
      } else {
        return _displayValue;
      }
    }

    final a = double.parse(_firstOperand);
    final b = double.parse(_secondOperand);
    double result;

    switch (_operator) {
      case '+':
        result = a + b;
        break;
      case '-':
        result = a - b;
        break;
      case '×':
        result = a * b;
        break;
      case '÷':
        if (b == 0) {
          _hasError = true;
          _displayValue = 'Error';
          return _displayValue;
        }
        result = a / b;
        break;
      default:
        return _displayValue;
    }

    // Save for continuous equals
    _lastOperator = _operator;
    _lastSecondOperand = _secondOperand;

    // Format result
    _displayValue = _formatNumber(result);

    // Check if result should be displayed in scientific notation
    final absResult = result.abs();
    if (absResult >= 1e15 || (absResult > 0 && absResult < 1e-8)) {
      _displayValue = result.toStringAsExponential(6);
    }

    _firstOperand = _displayValue;
    _operator = '';
    _secondOperand = '';
    _shouldResetDisplay = true;

    return _displayValue;
  }

  String _formatNumber(double value) {
    // Check if it's effectively an integer
    if (value == value.roundToDouble() && value.abs() < 1e15) {
      return value.toInt().toString();
    }

    // Format with max 8 decimal places, removing trailing zeros
    String formatted = value.toStringAsFixed(8);

    // Remove trailing zeros after decimal point
    if (formatted.contains('.')) {
      formatted = formatted.replaceAll(RegExp(r'0+$'), '');
      formatted = formatted.replaceAll(RegExp(r'\.$'), '');
    }

    return formatted;
  }
}
