import 'package:flutter/material.dart';
import '../core/services/favorites_service.dart';
import '../core/static/saved_card.dart';
import '../core/theme/AppColors.dart';
import 'DetailsScreen.dart';

class saved extends StatefulWidget {
  const saved({super.key});

  @override
  State<saved> createState() =>
      _savedState();
}

class _savedState
    extends State<saved> {

  Future<void> showRemoveDialog(
      BuildContext context,
      int id,
      ) async {

    showDialog(
      context: context, builder: (_) {
        return AlertDialog(
          title: Text("Remove Saved",style: TextStyle(fontWeight: FontWeight.bold,color: AppColors.font_elfra,)),
          content: Text("Do you want to remove this item from saved items?",style: TextStyle(color: AppColors.font_elfra,)),

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
  Widget build(
      BuildContext context) {

    final favorites = FavoritesService.getFavorites();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text("Saved", style: TextStyle(fontWeight: FontWeight.bold , color: AppColors.darkGold,),
        ),
      ),

      body: favorites.isEmpty ? Center(
        child: Text("No Saved Items",),
      )
          : ListView.builder(

        padding: EdgeInsets.all(16),

        itemCount: favorites.length,

        itemBuilder:
            (context, index) {

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
                        id: item["id"],
                        title: item["name"],
                        arabicName: item["arabic_name"],
                        image: item["image"],
                        description: item["description"] ?? "",
                      ),
                ),
              );
            },

            onSavePressed: () {
              showRemoveDialog(
                context, item["id"],);
            },
          );
        },
      ),
    );
  }
}