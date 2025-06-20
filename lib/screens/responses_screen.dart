import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class ResponsesScreen extends StatefulWidget {
  const ResponsesScreen({Key? key}) : super(key: key);

  @override
  _ResponsesScreenState createState() => _ResponsesScreenState();
}

class _ResponsesScreenState extends State<ResponsesScreen> {
  final FlutterTts _flutterTts = FlutterTts();
  final TextEditingController _searchController = TextEditingController();
  
  // Sample responses
  List<String> _commonResponses = [
    "I'm fine, thank you!",
    "That sounds great!",
    "I'm not sure about that.",
    "Could you clarify?",
    "Absolutely!",
    "I'm here to help.",
  ];
  List<String> _filteredResponses = [];

  @override
  void initState() {
    super.initState();
    // Initially, the filtered list will show all common responses
    _filteredResponses = List.from(_commonResponses);
  }

  // Function to filter responses based on search input
  void _filterResponses(String query) {
    final filtered = _commonResponses.where((response) {
      return response.toLowerCase().contains(query.toLowerCase());
    }).toList();

    setState(() {
      _filteredResponses = filtered.isNotEmpty ? filtered : ["No results found: Add this response"];
    });
  }

  // Function to handle adding a new response
  void _addResponse(String response) {
    if (!_commonResponses.contains(response) && response.isNotEmpty) {
      setState(() {
        _commonResponses.add(response);
        _filteredResponses = List.from(_commonResponses);
      });
      _searchController.clear();
    }
  }

  // Function to handle speaking a response
  Future<void> _speak(String text) async {
    await _flutterTts.setLanguage("en-US");
    await _flutterTts.setPitch(1.0);
    await _flutterTts.speak(text);
  }

  // Function to delete a response
  void _deleteResponse(String response) {
    setState(() {
      _commonResponses.remove(response);
      _filteredResponses.remove(response);
    });
  }

  // Function to handle adding to favorites (dummy function)
  void _addToFavorites(String response) {
    // Logic to add the response to favorites (not implemented here)
    print("$response added to favorites!"); // Placeholder for favorite functionality
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Responses"),
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
              onChanged: _filterResponses,
              decoration: InputDecoration(
                hintText: "Search for a response...",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            // List of filtered responses
            Expanded(
              child: ListView.builder(
                itemCount: _filteredResponses.length,
                itemBuilder: (context, index) {
                  final response = _filteredResponses[index];
                  return ListTile(
                    title: Text(response),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.speaker),
                          onPressed: () => _speak(response), // Text-to-Speech
                        ),
                        IconButton(
                          icon: const Icon(Icons.favorite),
                          onPressed: () => _addToFavorites(response), // Add to favorites
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _deleteResponse(response), // Delete response
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            // Add new response option
            if (_filteredResponses.contains("No results found: Add this response"))
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: ElevatedButton(
                  onPressed: () {
                    _addResponse(_searchController.text);
                  },
                  child: const Text("Add this response"),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
