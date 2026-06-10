import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../core/theme/AppColors.dart';

class chat extends StatelessWidget {
  const chat({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F4EE),

      appBar: AppBar(
        centerTitle: true,
        title: const Text("Chat With AI",
          style: TextStyle(
            color: AppColors.darkGold,
            fontWeight: FontWeight.bold,
          ),
        ),

        backgroundColor: const Color(0xffF7F4EE),
        elevation: 0,

        automaticallyImplyLeading: false,
      ),
    );
  }
}
