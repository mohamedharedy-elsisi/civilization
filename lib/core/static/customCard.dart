import 'package:flutter/material.dart';
import '../theme/AppColors.dart';

class CustomCard extends StatelessWidget {

  final String imageUrl;
  final String title;

  const CustomCard({
    super.key,
    required this.imageUrl,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      width: 280,
      margin: const EdgeInsets.only(
        right: 15,
      ),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
        BorderRadius.circular(20),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1,),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: [
          Expanded(
            child: ClipRRect(
              borderRadius:
              BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),

              child: Image.network(
                imageUrl,
                width: double.infinity,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, progress,)
                {
                  if (progress == null) {
                    return child;
                  }

                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },

                errorBuilder: (context, error, stackTrace,)
                {
                  return const Center(
                    child: Icon(Icons.broken_image, size: 50)
                  );
                },
              ),
            ),
          ),

          Padding(
            padding:
            EdgeInsets.all(12),
            child: Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 16,
                fontWeight:
                FontWeight.bold,
                color: AppColors.font_elfra,
              ),
            ),
          ),
        ],
      ),
    );
  }
}