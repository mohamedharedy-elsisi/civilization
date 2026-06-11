import 'package:civilization/core/theme/AppColors.dart';
import 'package:flutter/material.dart';

import '../core/static/customCard.dart';
// import '../widgets/custom_card.dart';

class CategoryScreen extends StatelessWidget {

  final String title;

  final List<dynamic> items;

  const CategoryScreen({
    super.key,
    required this.title,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor:
      Color(0xffF7F4EE),
      appBar: AppBar(
        title: Text(title,
          style: TextStyle(
            color: AppColors.darkGold,
            fontWeight: FontWeight.bold,
          ),),
        backgroundColor:
        Color(0xffF7F4EE),),

      body: GridView.builder(
        padding: EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(

          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          childAspectRatio: .75,
        ),

        itemCount: items.length,
        itemBuilder:
            (context, index) {

          final item = items[index];
          return CustomCard(
            imageUrl: item.image,
            title: item.name,
          );
        },
      ),
    );
  }
}