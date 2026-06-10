import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../core/theme/AppColors.dart';

class scan extends StatelessWidget {
  const scan({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F4EE),
      body: SafeArea(child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                  ),
                ),
                const Text(
                  "Scan",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkGold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
          ],
        ),
      )
      ),
    );
  }
}
