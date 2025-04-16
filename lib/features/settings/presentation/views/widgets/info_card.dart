import 'package:chat/constants.dart';
import 'package:chat/core/utils/assets.dart';
import 'package:chat/core/utils/styles.dart';
import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: kCardBackgroundColor,
          borderRadius: BorderRadius.circular(8),
        ),
        height: 80,
        width: double.infinity,
        child: Row(
          children: [
            const CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage(Assets.stockAvatar),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Aman Singh',
                  style:
                      Styles.textStyle20.copyWith(fontWeight: FontWeight.w600),
                ),
                Text(
                  '01273460737',
                  style:
                      Styles.textStyle14Regular.copyWith(color: Colors.black87),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
