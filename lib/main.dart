import 'package:crypto_diary/data/constants.dart';
import 'package:crypto_diary/data/notifiers.dart';
import 'package:crypto_diary/views/pages/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<void> _initThemeFuture;

  Future<void> initThemeMode() async {
    // Simulate a long initialization process to fetch the theme mode
    await Future.delayed(const Duration(milliseconds: 500));

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool? isDarkMode = prefs.getBool(Constants.themeModeKey);

    isDarkModeNotifier.value = isDarkMode ?? false;
  }

  @override
  void initState() {
    super.initState();
    _initThemeFuture = initThemeMode();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initThemeFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ValueListenableBuilder(
            valueListenable: isDarkModeNotifier,
            builder: (context, isDarkMode, child) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Crypto Diary',
                theme: ThemeData(
                  colorScheme: ColorScheme.fromSeed(
                    seedColor: Colors.deepPurple,
                    primary: Colors.deepPurple[400],
                    secondary: Colors.deepPurple[700],
                    brightness: isDarkMode ? Brightness.dark : Brightness.light,
                  ),
                  useMaterial3: true,
                ),
                home: const WelcomePage(),
              );
            },
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
