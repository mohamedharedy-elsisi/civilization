import 'package:civilization/views/cubits/home/home_cubit.dart';
import 'package:civilization/views/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/services/favorites_service.dart';
import 'core/theme/dark_theme.dart';
import 'core/theme/light_theme.dart';
import 'core/theme/theme_provider.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await FavoritesService.init();

  await Firebase.initializeApp();
  // await Supabase.initialize(
  //   url: "https://uebyussjytovjajhxgjg.supabase.co/rest/v1/",
  //   anonKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVlYnl1c3NqeXRvdmphamh4Z2pnIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODM0NjQ0NjMsImV4cCI6MjA5OTA0MDQ2M30.mAK9jK16FSJGSWkYe8zx0a579tcZA2bHPSj14G46ztA",
  // );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(),
        ),
      ],

      child: MultiBlocProvider(
        providers: [
          BlocProvider<HomeCubit>(
            create: (_) => HomeCubit(),
          ),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,

          theme: LightTheme.theme,
          darkTheme: DarkTheme.theme,
          themeMode: themeProvider.themeMode,

          home:  SplashScreen(),
        );
      },
    );
  }
}