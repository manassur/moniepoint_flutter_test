import 'package:flutter/material.dart';
import 'package:moniepoint_flutter_test/helper/char_helper.dart';

class BuyUi extends StatelessWidget {
  const BuyUi({
    required this.value,
    super.key,
  });

  final double value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 175,
      decoration: const BoxDecoration(
        color: Color(0xffFC9E12),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              "BUY",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontSize: 14,
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Text(
              CharHelper.addSpaceTo4DigitNumber(value.toInt()),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 35,
              ),
            ),
            const Text(
              "offers",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
