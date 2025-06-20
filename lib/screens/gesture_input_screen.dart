import 'package:flutter/material.dart';

class GestureInputScreen extends StatelessWidget {
  const GestureInputScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gesture Input"),
        centerTitle: true,
        backgroundColor: const Color(0xFF6200EE), // Use the same primary color
      ),
      body: Center(
        child: const Text(
          "Gesture Input Screen (Future Feature)",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
