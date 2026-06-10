import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class customCard extends StatelessWidget {
  final String imageUrl;

  const customCard({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      height: 190,
      margin: const EdgeInsets.only(right: 15),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.15),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),

        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,

          loadingBuilder:
              (context, child, progress) {
            if (progress == null) return child;

            return const Center(
              child:
              CircularProgressIndicator(),
            );
          },

          errorBuilder:
              (context, error, stackTrace) {
            return const Center(
              child: Icon(
                Icons.broken_image,
                size: 50,
              ),
            );
          },
        ),
      ),
    );
  }
}