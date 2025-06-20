import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final List<String> _favoritePhrases = [
    "Hello",
    "How are you?",
    "Please help me.",
    "Thank you.",
    "Goodbye",
    "I need assistance.",
    "What's your name?",
    "I'm hungry.",
    "I'm thirsty.",
    "Can I go to the bathroom?",
  ]; // Predefined favorite phrases
  final TextEditingController _phraseController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  final FlutterTts _flutterTts = FlutterTts();

  // Filtered phrases based on search
  List<String> get _filteredPhrases {
    String query = _searchController.text.toLowerCase();
    if (query.isEmpty) {
      return _favoritePhrases; // Return all phrases if no query
    }
    // Return filtered list based on query
    return _favoritePhrases
        .where((phrase) => phrase.toLowerCase().contains(query))
        .toList();
  }

  void _addPhrase() {
    final newPhrase = _phraseController.text.trim();
    if (newPhrase.isNotEmpty) {
      setState(() {
        _favoritePhrases.add(newPhrase); // Add new phrase to list
        _phraseController.clear(); // Clear the input field
      });
    }
  }

  void _deletePhrase(String phrase) {
    setState(() {
      _favoritePhrases.remove(phrase); // Remove phrase from list
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Deleted: $phrase')),
      );
    });
  }

  Future<void> _speak(String phrase) async {
    await _flutterTts.speak(phrase); // Use TTS to speak the phrase
  }

  @override
  void initState() {
    super.initState();
    // Refresh the UI when the search text changes
    _searchController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _searchController.dispose(); // Clean up the controllers
    _phraseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search Bar
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Search phrases',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {}); // Refresh the UI when text changes
              },
            ),
            const SizedBox(height: 16),
            // Add Phrase TextField
            TextField(
              controller: _phraseController,
              decoration: const InputDecoration(
                labelText: 'Add Phrase',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _addPhrase,
              child: const Text('Add Phrase'),
            ),
            const SizedBox(height: 16),
            // List of Favorite Phrases
            Expanded(
              child: _filteredPhrases.isNotEmpty // Check if filtered list is not empty
                  ? ListView.builder(
                      itemCount: _filteredPhrases.length,
                      itemBuilder: (context, index) {
                        final phrase = _filteredPhrases[index];
                        return ListTile(
                          title: Text(phrase),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.play_arrow),
                                onPressed: () => _speak(phrase), // TTS button
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  // Show confirmation dialog before deletion
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text('Delete Phrase'),
                                        content: const Text(
                                            'Are you sure you want to delete this phrase?'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              _deletePhrase(phrase); // Delete phrase
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('Yes'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('No'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    )
                  : const Center(child: Text('No phrases found')), // Message when no phrases
            ),
          ],
        ),
      ),
    );
  }
}
