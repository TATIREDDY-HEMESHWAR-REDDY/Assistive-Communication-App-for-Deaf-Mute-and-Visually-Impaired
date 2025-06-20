import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class GreetingsScreen extends StatefulWidget {
  const GreetingsScreen({Key? key}) : super(key: key);

  @override
  _GreetingsScreenState createState() => _GreetingsScreenState();
}

class _GreetingsScreenState extends State<GreetingsScreen> {
  final FlutterTts _flutterTts = FlutterTts();
  final TextEditingController _searchController = TextEditingController();
  List<String> _commonPhrases = [
    "Hello",
    "Good morning",
    "How are you?",
    "Thank you",
    "Goodbye",
    "See you later",
  ];
  List<String> _filteredPhrases = [];

  @override
  void initState() {
    super.initState();
    // Initially, the filtered list will show all common phrases
    _filteredPhrases = List.from(_commonPhrases);
  }

  // Function to filter phrases based on search input
  void _filterPhrases(String query) {
    final filtered = _commonPhrases.where((phrase) {
      return phrase.toLowerCase().contains(query.toLowerCase());
    }).toList();

    setState(() {
      _filteredPhrases = filtered.isNotEmpty ? filtered : ["No results found: Add this phrase"];
    });
  }

  // Function to handle adding a new phrase
  void _addPhrase(String phrase) {
    if (!_commonPhrases.contains(phrase) && phrase.isNotEmpty) {
      setState(() {
        _commonPhrases.add(phrase);
        _filteredPhrases = List.from(_commonPhrases);
      });
      _searchController.clear();
    }
  }

  // Function to handle speaking a phrase
  Future<void> _speak(String text) async {
    await _flutterTts.setLanguage("en-US");
    await _flutterTts.setPitch(1.0);
    await _flutterTts.speak(text);
  }

  // Function to delete a phrase
  void _deletePhrase(String phrase) {
    setState(() {
      _commonPhrases.remove(phrase);
      _filteredPhrases.remove(phrase);
    });
  }

  // Function to handle adding to favorites (dummy function)
  void _addToFavorites(String phrase) {
    // Logic to add the phrase to favorites (not implemented here)
    print("$phrase added to favorites!"); // Placeholder for favorite functionality
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Greetings"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Search Bar
            TextField(
              controller: _searchController,
              onChanged: _filterPhrases,
              decoration: InputDecoration(
                hintText: "Search for a phrase...",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            // List of filtered phrases
            Expanded(
              child: ListView.builder(
                itemCount: _filteredPhrases.length,
                itemBuilder: (context, index) {
                  final phrase = _filteredPhrases[index];
                  return ListTile(
                    title: Text(phrase),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.speaker),
                          onPressed: () => _speak(phrase), // Text-to-Speech
                        ),
                        IconButton(
                          icon: const Icon(Icons.favorite),
                          onPressed: () => _addToFavorites(phrase), // Add to favorites
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _deletePhrase(phrase), // Delete phrase
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            // Add new phrase option
            if (_filteredPhrases.contains("No results found: Add this phrase"))
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: ElevatedButton(
                  onPressed: () {
                    _addPhrase(_searchController.text);
                  },
                  child: const Text("Add this phrase"),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
