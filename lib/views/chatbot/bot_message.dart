import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BotMessage extends StatelessWidget {

  final String text;

  const BotMessage({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      EdgeInsets.only(bottom: 15),
      child: Row(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Image.asset(
            "assets/icons/chatbot2.png",
            width: 35, height: 35,
          ),

          SizedBox(width: 10),

          Expanded(
            child: Container(
              padding:
              EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(text),
            ),
          ),
        ],
      ),
    );
  }
}