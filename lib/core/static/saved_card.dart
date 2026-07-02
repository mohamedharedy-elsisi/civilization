import 'package:flutter/material.dart';

import '../theme/AppColors.dart';

class SavedCard extends StatelessWidget {

  final String title;
  final String arabicName;
  final String image;

  final VoidCallback onTap;
  final VoidCallback onSavePressed;

  const SavedCard({
    super.key,
    required this.title,
    required this.arabicName,
    required this.image,
    required this.onTap,
    required this.onSavePressed,
  });

  @override
  Widget build(
      BuildContext context) {

    return GestureDetector(
      onTap: onTap,
      child: Container(

        height: 120,
        margin:
        EdgeInsets.only(bottom: 16,),

        decoration:
        BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius:
          BorderRadius.circular(20,),
        ),

        child: Row(
          children: [
            ClipRRect(
              borderRadius:
              BorderRadius.only(
                topLeft:
                Radius.circular(20), 
                bottomLeft:
                Radius.circular(20),
              ),

              child: Image.network(
                image,
                width: 120,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            Expanded(
              child: Padding(
                padding:
                EdgeInsets.all(12),
                child: Column(
                  mainAxisAlignment:
                  MainAxisAlignment.center,
                  crossAxisAlignment:
                  CrossAxisAlignment.start,

                  children: [
                    Text(title,
                      maxLines: 1,
                      overflow:
                      TextOverflow.ellipsis,

                      style:
                      TextStyle(
                        fontSize: 18,
                        fontWeight:
                        FontWeight.bold,
                          color:Theme.of(context).textTheme.bodyLarge?.color
                      ),
                    ),

                    SizedBox(height: 6),
                    Text(arabicName,
                      maxLines: 1,
                      overflow:
                      TextOverflow.ellipsis,
                      style:
                      TextStyle(
                        fontSize: 16,
                          color:Theme.of(context).textTheme.bodyLarge?.color
                      ),
                    ),
                  ],
                ),
              ),
            ),

            IconButton(
              onPressed: onSavePressed,
              icon: Icon(
                Icons.bookmark,
                  color:Theme.of(context).textTheme.bodyLarge?.color
              ),
            ),
          ],
        ),
      ),
    );
  }
}