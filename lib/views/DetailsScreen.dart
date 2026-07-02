import 'package:cached_network_image/cached_network_image.dart';
import 'package:civilization/core/theme/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../core/services/favorites_service.dart';


class DetailsScreen extends StatefulWidget {

  final List<String> images;
  final int id;
  final String arabicName;
  final String title;
  final String description;

   DetailsScreen({
    super.key,
    required this.title,
    required this.description,
    required this.arabicName,
    required this.id,
    required this.images,
  });

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  bool isExpanded = false;
  late final bool showButton = widget.description.length > 200;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Text("Details", style: TextStyle(fontWeight: FontWeight.bold , color:Theme.of(context).iconTheme.color,),
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
        
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  height: 250,
                  viewportFraction: 1,
                  autoPlay: true,
                  enableInfiniteScroll: false,
                  enlargeCenterPage: false,
                ),
        
                items: widget.images.map((image) {
                    return ClipRRect(
                      borderRadius:
                      BorderRadius.circular(20,
                      ),
                      child: CachedNetworkImage(
                        imageUrl: image,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        ),
                        errorWidget: (context, url, error) => Center(
                          child: Icon(Icons.broken_image,
                            size: 50,
                          ),
                        ),

                        fadeInDuration: Duration(milliseconds: 200),
                      ),
                    );
                  },
                ).toList(),
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
                            color: Theme.of(context).textTheme.bodyLarge?.color,
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
                          "image": widget.images.first,
                          "description": widget.description,
                        });
        
                        setState(() {});
                      }
                    },
        
                    icon: Icon(
                      FavoritesService.isFavorite(widget.id) ? Icons.bookmark : Icons.bookmark_border,
                      color:  Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 50),

              Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.description,
                    maxLines: showButton ? (isExpanded ? null : 5) : null,
                    overflow:
                    showButton ? (isExpanded ? TextOverflow.visible : TextOverflow.ellipsis) : TextOverflow.visible,
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.5,
                      color: AppColors.primaryGold,
                    ),
                  ),

                  if (showButton)
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isExpanded = !isExpanded;
                        });
                      },
                      child: Text(
                        isExpanded ? "Show Less" : "Show More",
                        style: TextStyle(
                          color: Theme.of(context).iconTheme.color,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}