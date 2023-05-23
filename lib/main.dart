import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:todlist/database/db_helper.dart';
import 'package:todlist/firebase_options.dart';
import 'package:todlist/pages/intropage1.dart';
import 'package:todlist/pages/uptodo.dart';
import 'package:todlist/themes/theme.dart';
import 'package:todlist/themes/theme_services.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper.initDb();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
        theme: Themes.light,
        darkTheme: Themes.dark,
        themeMode: ThemeService().theme,
      );
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 1),
    ).then(
      (value) {
        Get.off(
            IntroPages()); // Замените на Get.off, чтобы перейти на Onboarding экран
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                MyFlutterApp.vector,
                size: 70,
                color: Color(0xFF8685E7),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(),
                child: GradientText(
                  "UpToDo",
                  style: GoogleFonts.lato(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  colors: const [
                    Color(0xFF8685E7),
                    Color.fromARGB(255, 255, 255, 255),
                    Color(0xFF8685E7),
                    Color.fromARGB(255, 255, 255, 255),
                    Color(0xFF8685E7),
                    Color.fromARGB(255, 255, 255, 255),
                    Color(0xFF8685E7),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
