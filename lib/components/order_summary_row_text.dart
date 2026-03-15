import 'package:flutter/widgets.dart';

class OrderSummaryRowText extends StatelessWidget {
  final String text;
  final Widget value;
  final bool isBoldText;
  final MainAxisAlignment mainAxisAlignment;
  const OrderSummaryRowText({
    super.key,
    required this.text,
    required this.value,
    required this.isBoldText,
    required this.mainAxisAlignment,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: isBoldText ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        const SizedBox(width: 12),
        value,
      ],
    );
  }
}
