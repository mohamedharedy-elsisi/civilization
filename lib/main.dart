import 'package:civilization/AuthScr/register_scr.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'AuthScr/forgetPassword_scr.dart';
import 'AuthScr/login_scr.dart';
import 'core/services/favorites_service.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await FavoritesService.init();
   // await Hive.box("favorites").clear();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
       // home: LoginScr(),
       home: RegisterScr(),
       //  home: ForgottenPasswordScr(),
      // home: splash_scr(),
    );
  }
}