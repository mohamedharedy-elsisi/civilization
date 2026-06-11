import 'package:civilization/core/theme/AppColors.dart';
import 'package:flutter/material.dart';

import '../core/services/favorites_service.dart';


class DetailsScreen extends StatefulWidget {


  final int id;
  final String arabicName;
  final String title;
  final String image;
  final String description;

  const DetailsScreen({
    super.key,
    required this.title,
    required this.image,
    required this.description, required this.arabicName, required this.id,
  });

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text("Details", style: TextStyle(fontWeight: FontWeight.bold , color: AppColors.darkGold,),
        ),
      ),

      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,

          children: [
            ClipRRect(
              borderRadius:
              BorderRadius.circular(20),
              child: Image.network(widget.image,
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
              ),
            ),

            SizedBox(height: 20),
            Row(
              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,

                    children: [
                      Text(widget.title,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight:
                          FontWeight.bold,
                          color: AppColors.font_elfra,
                        ),
                      ),

                      SizedBox(height: 4),

                      Text(widget.arabicName,
                        textDirection:
                        TextDirection.rtl,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight:
                          FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),

                IconButton(
                  onPressed: () {
                    if (FavoritesService.isFavorite(widget.id)) {

                      showDialog(
                        context: context,
                        builder: (_) {
                          return AlertDialog(
                            title: Text("Remove Favorite",),
                            content: Text("Do you want to remove this item from saved items?",),

                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context,);
                                },

                                child: Text("Cancel",
                                ),
                              ),

                              ElevatedButton(
                                onPressed: () {
                                  FavoritesService.removeFavorite(widget.id,);
                                  setState(() {});
                                  Navigator.pop(
                                    context,
                                  );
                                },

                                child: Text("Remove",),
                              ),
                            ],
                          );
                        },
                      );

                    } else {
                      FavoritesService.addFavorite({
                        "id": widget.id,
                        "name": widget.title,
                        "arabic_name": widget.arabicName,
                        "image": widget.image,
                        "description": widget.description,
                      });

                      setState(() {});
                    }
                  },

                  icon: Icon(
                    FavoritesService.isFavorite(widget.id) ? Icons.bookmark : Icons.bookmark_border,
                    color: AppColors.font_elfra,
                  ),
                ),
              ],
            ),

            SizedBox(height: 50),
            Text(widget.description,
              style: TextStyle(
                fontSize: 16,
                height: 1.5,
                color: AppColors.primaryGold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}