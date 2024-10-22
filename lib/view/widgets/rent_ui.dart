import 'package:flutter/material.dart';
import 'package:moniepoint_flutter_test/helper/char_helper.dart';

class RentUi extends StatelessWidget {
  const RentUi({
    required this.value,
    super.key,
  });

  final double value;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 175,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xffFDF8F2),
            Color(0xfff8ede3),
            Color(0xffFDF8F2),
            Color(0xffFDF8F2),
            Colors.white,
            Colors.white,
          ],
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(24),
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              "RENT",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Color(0xffA5957E),
                fontSize: 14,
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Text(
              CharHelper.addSpaceTo4DigitNumber(value.toInt()),
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                color: Color(0xffA5957E),
                fontSize: 35,
              ),
            ),
            const Text(
              "offers",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Color(0xffA5957E),
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
