import 'package:civilization/core/theme/AppColors.dart';
import 'package:flutter/material.dart';

import '../core/static/customCard.dart';
import 'DetailsScreen.dart';
// import '../widgets/custom_card.dart';

class CategoryScreen extends StatelessWidget {

  final String title;
  final List<dynamic> items;
  final String Function(dynamic) imageBuilder;
  final Widget Function(dynamic) detailsBuilder;

  const CategoryScreen({
    super.key,
    required this.title,
    required this.items,
    required this.imageBuilder,
    required this.detailsBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(title,
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyLarge?.color,
            fontWeight: FontWeight.bold,
          ),),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          childAspectRatio: .75,
        ),

        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(context,
                MaterialPageRoute(
                  builder: (_) =>
                      detailsBuilder(item),
                ),
              );
            },
            child: CustomCard(
              imageUrl: imageBuilder(item),
              title: item.name,
            )
          );
        },
      ),
    );
  }
}