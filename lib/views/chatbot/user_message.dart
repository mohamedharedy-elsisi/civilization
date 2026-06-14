import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserMessage extends StatelessWidget {

  final String text;

  const UserMessage({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15),
      child: Row(
        mainAxisAlignment:
        MainAxisAlignment.end,
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(12)
              ),

              child: Text(
                text,
                textAlign: TextAlign.end
              ),
            ),
          ),

          SizedBox(width: 10),
          Image.asset(
            "assets/icons/user.png",
            width: 35, height: 35
          ),
        ],
      ),
    );
  }
}