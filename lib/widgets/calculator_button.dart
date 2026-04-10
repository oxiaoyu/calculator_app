import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/candy_colors.dart';

/// Calculator button widget with press animation and haptic feedback
class CalculatorButton extends StatefulWidget {
  final String label;
  final ButtonType type;
  final VoidCallback onPressed;
  final int flex;
  final double fontSize;

  const CalculatorButton({
    super.key,
    required this.label,
    required this.type,
    required this.onPressed,
    this.flex = 1,
    this.fontSize = 24,
  });

  @override
  State<CalculatorButton> createState() => _CalculatorButtonState();
}

class _CalculatorButtonState extends State<CalculatorButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color get _backgroundColor {
    if (_isPressed) {
      switch (widget.type) {
        case ButtonType.number:
          return CandyColors.numberButtonPressed;
        case ButtonType.operator:
          return CandyColors.operatorButtonPressed;
        case ButtonType.function:
          return CandyColors.functionButtonPressed;
        case ButtonType.equals:
          return CandyColors.equalsButtonPressed;
      }
    }

    switch (widget.type) {
      case ButtonType.number:
        return CandyColors.numberButtonBg;
      case ButtonType.operator:
        return CandyColors.operatorButtonBg;
      case ButtonType.function:
        return CandyColors.functionButtonBg;
      case ButtonType.equals:
        return CandyColors.equalsButtonBg;
    }
  }

  Color get _textColor {
    switch (widget.type) {
      case ButtonType.number:
        return CandyColors.numberButtonText;
      case ButtonType.operator:
        return CandyColors.operatorButtonText;
      case ButtonType.function:
        return CandyColors.functionButtonText;
      case ButtonType.equals:
        return CandyColors.equalsButtonText;
    }
  }

  void _handleTapDown(TapDownDetails details) {
    setState(() => _isPressed = true);
    _controller.forward();
    HapticFeedback.lightImpact();
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() => _isPressed = false);
    _controller.reverse();
    widget.onPressed();
  }

  void _handleTapCancel() {
    setState(() => _isPressed = false);
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: widget.flex,
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: GestureDetector(
          onTapDown: _handleTapDown,
          onTapUp: _handleTapUp,
          onTapCancel: _handleTapCancel,
          child: AnimatedBuilder(
            animation: _scaleAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _scaleAnimation.value,
                child: Container(
                  height: 64,
                  decoration: BoxDecoration(
                    color: _backgroundColor,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        offset: const Offset(0, 2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      widget.label,
                      style: TextStyle(
                        color: _textColor,
                        fontSize: widget.fontSize,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
