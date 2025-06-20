import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class TapInputScreen extends StatefulWidget {
  const TapInputScreen({Key? key}) : super(key: key);

  @override
  _TapInputScreenState createState() => _TapInputScreenState();
}

class _TapInputScreenState extends State<TapInputScreen> {
  final FlutterTts flutterTts = FlutterTts();
  String currentInput = ""; // Track current input
  List<bool> activeDots = List.filled(6, false); // Track active dots for Braille

  // Correct Braille mapping for A-Z and space/backspace
  final Map<String, String> brailleMap = {
    '1': 'A',
    '12': 'B',
    '14': 'C',
    '145': 'D',
    '15': 'E',
    '124': 'F',
    '1245': 'G',
    '125': 'H',
    '24': 'I',
    '245': 'J',
    '13': 'K',
    '123': 'L',
    '134': 'M',
    '1345': 'N',
    '135': 'O',
    '1234': 'P',
    '12345': 'Q',
    '1235': 'R',
    '234': 'S',
    '2345': 'T',
    '136': 'U',
    '126': 'V',
    '2456': 'W',
    '1346': 'X',
    '13456': 'Y',
    '1356': 'Z',
    '': ' ', // Space (no dots)
  };

  // Initialize TTS properties
  Future<void> _initTTS() async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1.0);
  }

  // Speak the full user input when confirmed
  Future<void> speak(String text) async {
    await flutterTts.speak(text);
  }

  @override
  void initState() {
    super.initState();
    _initTTS(); // Initialize TTS
  }

  // Update the active dots and check for a letter
  void _handleTap(int index) {
    setState(() {
      activeDots[index] = !activeDots[index]; // Toggle the dot state
    });
  }

  // Reset input and dots
  void _resetInput() {
    setState(() {
      currentInput = ""; // Clear current input
      activeDots = List.filled(6, false); // Reset active dots
    });
  }

  // Confirm the input when the user taps the 'Confirm' button
  void _confirmInput() {
    String tappedDots = '';
    for (int i = 0; i < activeDots.length; i++) {
      if (activeDots[i]) {
        tappedDots += (i + 1).toString(); // Build the tapped dots string
      }
    }

    // Check if we have a corresponding letter in brailleMap
    String letter = brailleMap[tappedDots] ?? '';
    if (letter.isNotEmpty) {
      setState(() {
        currentInput += letter; // Update current input with recognized letter
        activeDots = List.filled(6, false); // Reset active dots after confirming
      });
      speak(letter); // Speak the added letter
    }
  }

  // Confirm the input on single tap and read the entire sentence on double tap
  void _onConfirmTap() {
    _confirmInput();
  }

  // Handle double tap to read the entire sentence
  void _onConfirmDoubleTap() {
    if (currentInput.isNotEmpty) {
      speak(currentInput); // Speak the recognized input
    }
  }

  // Backspace functionality
  void _backspace() {
    if (currentInput.isNotEmpty) {
      setState(() {
        currentInput = currentInput.substring(0, currentInput.length - 1); // Remove last character
      });
    }
  }

  // Clear input on long press
  void _clearInput() {
    setState(() {
      currentInput = ""; // Clear the input entirely
      activeDots = List.filled(6, false); // Reset active dots
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Braille Tap Input"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade100, Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: GridView.count(
                physics: const NeverScrollableScrollPhysics(), // Prevent scrolling
                crossAxisCount: 2,
                childAspectRatio: 1, // Ensure buttons are square
                children: [
                  // First three rows for Braille dots (1-6) in specified layout
                  _buildDot(0), _buildDot(3),
                  _buildDot(1), _buildDot(4),
                  _buildDot(2), _buildDot(5),
                  // Fourth row with Confirm and Backspace buttons
                  _buildConfirmButton(), _buildBackspaceButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Build individual Braille dot
  Widget _buildDot(int index) {
    return GestureDetector(
      onTap: () => _handleTap(index), // Handle dot tap
      child: Container(
        decoration: BoxDecoration(
          color: activeDots[index] ? Colors.blue : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(12), // Rounded corners for buttons
          border: Border.all(color: Colors.black, width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade400,
              offset: const Offset(2, 2),
              blurRadius: 4,
            ),
          ],
        ),
        child: Center(
          child: Text(
            (index + 1).toString(),
            style: const TextStyle(
              color: Colors.transparent, // Hide number
            ),
          ),
        ),
      ),
    );
  }

  // Build Confirm button
  Widget _buildConfirmButton() {
    return GestureDetector(
      onTap: _onConfirmTap, // Confirm input on single tap
      onDoubleTap: _onConfirmDoubleTap, // Read input on double tap
      child: Container(
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(12), // Rounded corners
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade600,
              offset: const Offset(2, 2),
              blurRadius: 4,
            ),
          ],
        ),
        child: const Center(
          child: Text(
            "Confirm",
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
        ),
      ),
    );
  }

  // Build Backspace button with long press to clear input
  Widget _buildBackspaceButton() {
    return GestureDetector(
      onTap: _backspace, // Backspace on button press
      onLongPress: _clearInput, // Clear input on long press
      child: Container(
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(12), // Rounded corners
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade600,
              offset: const Offset(2, 2),
              blurRadius: 4,
            ),
          ],
        ),
        child: const Center(
          child: Text(
            "Backspace",
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
        ),
      ),
    );
  }
}
