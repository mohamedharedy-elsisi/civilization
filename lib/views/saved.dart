import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../core/services/favorites_service.dart';
import '../core/static/saved_card.dart';
import '../core/theme/AppColors.dart';
import 'DetailsScreen.dart';

class saved extends StatefulWidget {
  const saved({super.key});

  @override
  State<saved> createState() => _savedState();
}

class _savedState extends State<saved> {

  Future<void> showRemoveDialog(
      BuildContext context,
      int id,
      ) async {

    showDialog(
      context: context, builder: (_) {
        return AlertDialog(
          title: Text("Remove Saved",style: TextStyle(fontWeight: FontWeight.bold,color: Theme.of(context).textTheme.bodyLarge?.color,)),
          content: Text("Do you want to remove this item from saved items?",style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color,)),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(
                  context,
                );
              },
              child: Text("Cancel",style: TextStyle(color: AppColors.brown,)),
            ),

            ElevatedButton(
              onPressed: () {
                FavoritesService.removeFavorite(id);
                setState(() {});

                Navigator.pop(context,);
                },
              child: Text("Remove",style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Text(
          "Saved",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).textTheme.bodyLarge?.color,
          ),
        ),
      ),

      body: ValueListenableBuilder(
        valueListenable: FavoritesService.box.listenable(),
        builder: (context, box, _) {

          final favorites = box.values.cast<Map>().toList();

          if (favorites.isEmpty) {
            return Center(
              child: Text(
                "No Saved Items",
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: favorites.length,
            itemBuilder: (context, index) {

              final item = favorites[index];

              return SavedCard(
                title: item["name"],
                arabicName: item["arabic_name"],
                image: item["image"],

                onTap: () {
                  Navigator.push(context,
                    MaterialPageRoute(
                      builder: (_) =>
                          DetailsScreen(
                            id: item["id"] ?? 0,
                            title: item["name"] ?? "",
                            arabicName: item["arabic_name"] ?? "",
                            images: List<String>.from(item["images"] ?? [item["image"]]),
                            description: item["description"] ?? "",

                            // Pharaohs
                            capital: item["capital"],
                            achievements: item["achievements"] != null
                                ? List<String>.from(item["achievements"]) : null,
                            dynasty: item["dynasty"],

                            // Temples & Pyramids
                            city: item["city"],
                            period: item["period"],
                            builtBy: item["built_by"],

                            // Statues
                            material: item["material"],
                            heightM: item["height_m"] != null
                                ? (item["height_m"] as num).toDouble() : null,

                            // Museums
                            established: item["established"],

                            // Obelisks
                            historicalEra: item["historical_era"],
                            location: item["location"],
                          ),
                    ),
                  );
                },

                onSavePressed: () {
                  showRemoveDialog(
                    context,
                    item["id"] ?? 0,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}