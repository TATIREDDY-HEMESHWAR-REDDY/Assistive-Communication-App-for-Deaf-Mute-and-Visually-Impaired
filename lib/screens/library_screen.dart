import 'package:flutter/material.dart';
import 'greetings_screen.dart'; // Import the Greetings screen
import 'responses_screen.dart'; // Import the Responses screen
import 'common_questions_screen.dart'; // Import the Common Questions screen

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({Key? key}) : super(key: key);

  @override
  _LibraryScreenState createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Library"),
        backgroundColor: Colors.teal, // Change the app bar color
        centerTitle: true, // Center the title
        elevation: 5, // Add elevation to the app bar
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.teal[300]!, // Light teal
              Colors.teal[700]!, // Dark teal
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch, // Ensure buttons stretch across
            children: [
              // Library Header
              Text(
                "Select a Category",
                textAlign: TextAlign.center, // Center the header text
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 30), // Spacing for visual appeal

              // Greetings Button
              _buildLibraryButton(
                context,
                label: "Greetings",
                icon: Icons.waving_hand, // Icon for Greetings
                destination: const GreetingsScreen(),
              ),
              const SizedBox(height: 20), // Spacing between buttons

              // Responses Button
              _buildLibraryButton(
                context,
                label: "Responses",
                icon: Icons.comment, // Icon for Responses
                destination: const ResponsesScreen(),
              ),
              const SizedBox(height: 20), // Spacing between buttons

              // Common Questions Button
              _buildLibraryButton(
                context,
                label: "Common Questions",
                icon: Icons.question_answer, // Icon for Common Questions
                destination: const CommonQuestionsScreen(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper function to build library buttons
  Widget _buildLibraryButton(BuildContext context, {required String label, required Widget destination, required IconData icon}) {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destination),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white, // Button background color
        foregroundColor: Colors.teal, // Button text color
        padding: const EdgeInsets.symmetric(vertical: 15), // Vertical padding
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30), // Rounded corners
          side: const BorderSide(color: Colors.teal, width: 2), // Teal border
        ),
        elevation: 5, // Shadow effect
      ),
      icon: Icon(icon, size: 28, color: Colors.teal), // Icon on the button
      label: Text(
        label,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}
