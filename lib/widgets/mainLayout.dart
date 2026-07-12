import 'package:flutter/material.dart';

import '../core/services/ai_service.dart';
import '../views/chatbot/chat.dart';
import '../views/home.dart';
import '../views/profile.dart';
import '../views/saved.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int currentIndex = 0;

  final List<Widget> screens = [
    const home(),
    const chat(),
    const saved(),
    const profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),

      floatingActionButton: currentIndex == 0
          ? GestureDetector(
        onTap: () async {
          await AIService.showImageSourceDialog(context);
        },
        child: Container(
          width: 60,
          height: 60,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                Color(0xffF8E7A1),
                Color(0xffD4AF37),
                Color(0xff9E6B1A),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Center(
            child: Image.asset(
              "assets/icons/artifact.png",
              width: 24,
              height: 24,
            ),
          ),
        ),
      )
          : null,

      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

      bottomNavigationBar: Container(
        height: 75,
        margin: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.1),
              blurRadius: 10,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            navItem(
              index: 0,
              image: "assets/icons/home.png",
            ),
            navItem(
              index: 1,
              image: "assets/icons/chat.png",
            ),
            navItem(
              index: 2,
              image: "assets/icons/saved.png",
            ),
            navItem(
              index: 3,
              image: "assets/icons/user2.png",
            ),
          ],
        ),
      ),
    );
  }

  Widget navItem({
    required int index,
    required String image,
  }) {
    final bool isSelected = currentIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          currentIndex = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xffD4AF37).withOpacity(.2)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Image.asset(
          image,
          width: isSelected ? 30 : 24,
          height: isSelected ? 30 : 24,
        ),
      ),
    );
  }
}