import 'package:flutter/material.dart';
import '../theme/candy_colors.dart';

/// Calculator display widget showing current input/result
class CalculatorDisplay extends StatelessWidget {
  final String value;
  final String? expression;

  const CalculatorDisplay({
    super.key,
    required this.value,
    this.expression,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: const BoxDecoration(
        color: CandyColors.displayBg,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (expression != null && expression!.isNotEmpty) ...[
            Text(
              expression!,
              style: const TextStyle(
                color: Color(0xFF757575),
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
          ],
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerRight,
            child: Text(
              value,
              style: const TextStyle(
                color: CandyColors.displayText,
                fontSize: 56,
                fontWeight: FontWeight.w300,
              ),
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}
