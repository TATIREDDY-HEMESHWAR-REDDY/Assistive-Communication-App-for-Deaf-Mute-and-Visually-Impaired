import 'package:flutter/material.dart';
import 'profile_screen.dart';
import 'options_screen.dart';
import 'library_screen.dart';
import 'favorites_screen.dart'; // Optional for favorites button
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Use Font Awesome for icons
import 'package:flutter_tts/flutter_tts.dart'; // Import Text-to-Speech package
import 'input_method_screen.dart'; // Import the new input method screen

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FlutterTts _flutterTts = FlutterTts();
  String _inputText = ""; // For holding the text from the input field

  // Custom primary color
  Color primaryColor = const Color(0xFF4A148C); // Deep purple for a premium look

  // Function to read text aloud
  Future<void> _speak(String text) async {
    await _flutterTts.setLanguage("en-US");
    await _flutterTts.setPitch(1.0);
    await _flutterTts.speak(text);
  }

  // Function to handle input change
  void _onInputChanged(String value) {
    setState(() {
      _inputText = value; // Update input text
    });
  }

  // Common phrases to read
  final List<String> _commonPhrases = [
    "Hello",
    "Thank you",
    "Please",
    "Goodbye",
    "Yes",
    "No",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6), // Soft grey background
      appBar: AppBar(
        title: const Text(
          "Vakpatir Home",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        centerTitle: true,
        backgroundColor: primaryColor, // AppBar color
        elevation: 4,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white), // White settings icon
            onPressed: () {
              // Navigate to Settings Screen
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Input Bar for Typing Phrases
              TextField(
                onChanged: _onInputChanged,
                style: const TextStyle(color: Colors.black, fontSize: 16),
                decoration: InputDecoration(
                  hintText: "Type your phrase...",
                  hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  filled: true,
                  fillColor: Colors.white, // White input field for contrast
                  contentPadding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 16.0),
                ),
              ),
              const SizedBox(height: 24),
              // Button to Speak Input Phrase
              ElevatedButton(
                onPressed: () {
                  if (_inputText.isNotEmpty) {
                    _speak(_inputText); // Speak the input text
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor, // Primary button color
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // Rounded corners
                  ),
                  elevation: 6, // Shadow effect
                ),
                child: const Text(
                  "Speak Input Phrase",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // White text for contrast
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Common Phrases Section
              const Text(
                "Common Phrases:",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4A148C), // Primary color for header
                ),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 16, // Horizontal spacing
                runSpacing: 16, // Vertical spacing
                alignment: WrapAlignment.center,
                children: _commonPhrases.map((phrase) {
                  return ElevatedButton(
                    onPressed: () => _speak(phrase), // Speak the common phrase
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white, // White button color
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                        side: const BorderSide(color: Color(0xFF4A148C), width: 2), // Primary border
                      ),
                      elevation: 3, // Shadow effect
                    ),
                    child: Text(
                      phrase,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF4A148C), // Primary text color
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),
              // Navigate Buttons
              _buildNavigationButton(context, "Library", const LibraryScreen(), FontAwesomeIcons.book),
              const SizedBox(height: 16),
              _buildNavigationButton(context, "Favorites", const FavoritesScreen(), FontAwesomeIcons.heart),
              const SizedBox(height: 16),
              _buildNavigationButton(context, "Manage Profile", const ProfileScreen(), FontAwesomeIcons.user),
              const SizedBox(height: 16),
              _buildNavigationButton(context, "Options", const OptionsScreen(), FontAwesomeIcons.cog),
              const SizedBox(height: 16),
              // Button for Input Method Screen
              _buildNavigationButton(context, "Input Methods", const InputMethodScreen(), FontAwesomeIcons.tasks),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  // Helper function to build navigation buttons
  Widget _buildNavigationButton(BuildContext context, String label, Widget destination, IconData icon) {
    return ElevatedButton.icon(
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => destination),
      ),
      icon: Icon(icon, color: const Color(0xFF4A148C)), // Primary icon color
      label: Text(
        label,
        style: const TextStyle(
          color: Color(0xFF4A148C),
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white, // White button color
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30), // Rounded corners
          side: const BorderSide(color: Color(0xFF4A148C), width: 2), // Primary border
        ),
        elevation: 3, // Shadow effect
      ),
    );
  }
}
