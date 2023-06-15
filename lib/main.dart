import 'package:flutter/material.dart';
import 'package:hello_world/src/pages/splash/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Greengrocer',
        theme: ThemeData(
          primarySwatch: Colors.green,
          scaffoldBackgroundColor: Colors.white.withAlpha(190)
        ),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
    );
  }
}
