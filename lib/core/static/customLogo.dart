import 'package:flutter/material.dart';
import '../constant.dart';

class CustomLogo extends StatelessWidget {

  final double size;

  const CustomLogo({
    super.key,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: size,
      width: size,

      child: Image.asset(
        AppConstant.logo,
        fit: BoxFit.contain,
      ),
    );
  }
}