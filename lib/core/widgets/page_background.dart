import 'package:flutter/material.dart';

class PageBackground extends StatelessWidget {
  final Widget child;
  final String image;

  const PageBackground({
    super.key,
    required this.child,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Stack(
      children: [
        if (isDark)
          Positioned.fill(
            child: Image.asset(
              image,
              fit: BoxFit.cover,
            ),
          ),

        if (isDark)
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(.45),
            ),
          ),

        child,
      ],
    );
  }
}