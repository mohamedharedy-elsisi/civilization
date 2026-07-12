import 'package:civilization/core/theme/AppColors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../AuthScr/login_scr.dart';
import '../widgets/mainLayout.dart';
import 'home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.asset(
      "assets/lottie/Artboard1.mp4",
    )
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
      });

    _controller.setLooping(false);

    _controller.addListener(() {
      if (_controller.value.position >= _controller.value.duration &&
          !_controller.value.isPlaying) {
        _navigate();
      }
    });
  }

  void _navigate() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // تحديث بيانات المستخدم
      await user.reload();

      final refreshedUser = FirebaseAuth.instance.currentUser;

      if (!mounted) return;

      if (refreshedUser != null && refreshedUser.emailVerified) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const MainLayout(),
          ),
        );
      } else {
        // لو الحساب مش مفعل يسجيل خروج
        await FirebaseAuth.instance.signOut();

        if (!mounted) return;

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) =>  LoginScr(),
          ),
        );
      }
    } else {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) =>  LoginScr(),
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    if (!_controller.value.isInitialized) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: SizedBox(
          width: 320,
          height: 220,
          child: VideoPlayer(_controller),
        ),
      ),
    );
  }
}