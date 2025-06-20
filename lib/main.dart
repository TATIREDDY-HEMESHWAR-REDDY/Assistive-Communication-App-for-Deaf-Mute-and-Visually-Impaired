import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const VakpatirApp());
}

class VakpatirApp extends StatelessWidget {
  const VakpatirApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vakpatir',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.system,
      home: const HomeScreen(),
    );
  }
}
