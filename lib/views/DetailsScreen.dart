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
  final String? capital;
  final List<String>? achievements;
  final String? city;
  final String? period;
  final String? builtBy;
  final String? material;
  final double? heightM;
  final int? established;
  final String? builder;
  final String? dynasty;
  final String? historicalEra;
  final String? location;

  DetailsScreen({
    super.key,
    required this.title,
    required this.description,
    required this.arabicName,
    required this.id,
    required this.images,
     this.city,
     this.period,
     this.builtBy,
     this.capital,
     this.achievements,
    this.heightM,
    this.material,
    this.established,
    this.builder,
    this.dynasty,
    this.historicalEra,
    this.location
  });

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late bool isFavorite;
  @override
  void initState() {
    super.initState();
    isFavorite = FavoritesService.isFavorite(widget.id);
  }
  Widget infoCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xffD4AF37).withOpacity(.10),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xffD4AF37),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.08),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Color(0xffD4AF37),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 20,
            ),
          ),

          const SizedBox(width: 15),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xffD4AF37),
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  value,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
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
                        fit: BoxFit.contain,
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
                    onPressed: () async {
                      if (isFavorite) {
                        showDialog(
                          context: context,
                          builder: (_) {
                            return AlertDialog(
                              title: const Text("Remove Favorite"),
                              content: const Text(
                                "Do you want to remove this item from saved items?",
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Cancel"),
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    await FavoritesService.removeFavorite(widget.id);

                                    if (mounted) {
                                      setState(() {
                                        isFavorite = false;
                                      });
                                    }

                                    Navigator.pop(context);
                                  },
                                  child: const Text("Remove"),
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        await FavoritesService.addFavorite({
                          "id": widget.id,
                          "name": widget.title,
                          "arabic_name": widget.arabicName,
                          "image": widget.images.first,
                          "images": widget.images,
                          "description": widget.description,
                          "capital": widget.capital,
                          "achievements": widget.achievements,
                          "dynasty": widget.dynasty,
                          "city": widget.city,
                          "period": widget.period,
                          "built_by": widget.builtBy,
                          "material": widget.material,
                          "height_m": widget.heightM,
                          "established": widget.established,
                          "historical_era": widget.historicalEra,
                          "location": widget.location,
                        });

                        if (mounted) {
                          setState(() {
                            isFavorite = true;
                          });
                        }
                      }
                    },
        
                    icon: Icon(isFavorite ? Icons.bookmark : Icons.bookmark_border,),
                      color:  Theme.of(context).textTheme.bodyLarge?.color,
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
                  if (widget.city != null) ...[
                    const SizedBox(height: 25),
                    infoCard(
                      icon: Icons.location_city,
                      title: "City",
                      value: widget.city!,
                    ),
                  ],
                  if (widget.location != null) ...[
                    infoCard(
                      icon: Icons.place,
                      title: "location",
                      value: widget.location!,
                    ),
                  ],
                  if (widget.historicalEra != null) ...[

                    infoCard(
                      icon: Icons.date_range,
                      title: "historical erea",
                      value: widget.historicalEra!,
                    ),
                  ],
                  if (widget.established != null) ...[
                    infoCard(
                      icon: Icons.history_edu,
                      title: "established",
                      value: widget.established?.toString() ?? "",
                    ),
                  ],

                  if (widget.period != null) ...[
                    infoCard(
                      icon: Icons.timelapse,
                      title: "Period",
                      value: widget.period!,
                    ),
                  ],
                  if (widget.material != null) ...[
                    infoCard(
                      icon: Icons.star_border,
                      title: "material",
                      value: widget.material!,
                    ),
                  ],
                  if (widget.heightM != null) ...[
                    infoCard(
                      icon: Icons.straighten_outlined,
                      title: "heightM",
                      value: widget.heightM?.toString() ?? "",
                    ),
                  ],

                  if (widget.builtBy != null) ...[
                    infoCard(
                      icon: Icons.account_balance,
                      title: "Built By",
                      value: widget.builtBy!,
                    ),
                  ],
                  if (widget.builder != null) ...[
                    infoCard(
                      icon: Icons.account_balance,
                      title: "builder",
                      value: widget.builder!,
                    ),
                  ],

                  if (widget.capital != null) ...[
                    infoCard(
                      icon: Icons.location_on,
                      title: "Capital",
                      value: widget.capital!,
                    ),
                  ],
                  if (widget.dynasty != null) ...[
                    infoCard(
                      icon: Icons.timer,
                      title: "dynasty",
                      value: widget.dynasty!,
                    ),
                  ],

                  if (widget.achievements != null &&
                      widget.achievements!.isNotEmpty) ...[
                    const SizedBox(height: 30),

                    Text(
                      "Achievements",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).iconTheme.color,
                      ),
                    ),

                    const SizedBox(height: 12),

                    ...widget.achievements!.map(
                          (achievement) => Container(
                        margin: EdgeInsets.only(bottom: 12),
                        padding:  EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Color(0xffD4AF37).withOpacity(.12),
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: Color(0xffD4AF37),
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.star,
                              color: Color(0xffD4AF37),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                achievement,
                                style: TextStyle(
                                  fontSize: 16,
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

}