import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  final String text;

  const CustomDivider({
    super.key,
    this.text = "OR",
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: Colors.grey.shade500,
            thickness: 1,
          ),
        ),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            text,
            style: TextStyle(
              color: Colors.grey.shade700,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ),

        Expanded(
          child: Divider(
            color: Colors.grey.shade500,
            thickness: 1,
          ),
        ),
      ],
    );
  }
}