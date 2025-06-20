import 'package:flutter/material.dart';
import 'gesture_input_screen.dart'; // Import your Gesture Input Screen
import 'tap_input_screen.dart'; // Import your Tap Input Screen

class InputMethodScreen extends StatelessWidget {
  const InputMethodScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Input Method"),
        centerTitle: true,
        backgroundColor: const Color(0xFF6200EE), // Primary color
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFEDE7F6), // Light background
              Color(0xFFF3E5F5), // Lighter background
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildInputButton(
              context,
              "Gesture Input (Future Feature)",
              Icons.gesture,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const GestureInputScreen()),
                );
              },
            ),
            const SizedBox(height: 20),
            _buildInputButton(
              context,
              "Tap Input",
              Icons.touch_app,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TapInputScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputButton(BuildContext context, String text, IconData icon, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: const Color(0xFF6200EE), width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 3,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: const Color(0xFF6200EE)), // Icon for the button
              const SizedBox(width: 10), // Spacing between icon and text
              Text(
                text,
                style: const TextStyle(
                  color: Color(0xFF6200EE), // Primary text color
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
