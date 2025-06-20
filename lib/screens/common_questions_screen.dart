import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class CommonQuestionsScreen extends StatefulWidget {
  const CommonQuestionsScreen({Key? key}) : super(key: key);

  @override
  _CommonQuestionsScreenState createState() => _CommonQuestionsScreenState();
}

class _CommonQuestionsScreenState extends State<CommonQuestionsScreen> {
  final FlutterTts _flutterTts = FlutterTts();
  final TextEditingController _searchController = TextEditingController();
  
  // Sample questions
  List<String> _commonQuestions = [
    "What is your name?",
    "How are you today?",
    "What do you like to do?",
    "Can you help me with this?",
    "What time is it?",
    "Where are you from?",
  ];
  List<String> _filteredQuestions = [];

  @override
  void initState() {
    super.initState();
    // Initially, the filtered list will show all common questions
    _filteredQuestions = List.from(_commonQuestions);
  }

  // Function to filter questions based on search input
  void _filterQuestions(String query) {
    final filtered = _commonQuestions.where((question) {
      return question.toLowerCase().contains(query.toLowerCase());
    }).toList();

    setState(() {
      _filteredQuestions = filtered.isNotEmpty ? filtered : ["No results found: Add this question"];
    });
  }

  // Function to handle adding a new question
  void _addQuestion(String question) {
    if (!_commonQuestions.contains(question) && question.isNotEmpty) {
      setState(() {
        _commonQuestions.add(question);
        _filteredQuestions = List.from(_commonQuestions);
      });
      _searchController.clear();
    }
  }

  // Function to handle speaking a question
  Future<void> _speak(String text) async {
    await _flutterTts.setLanguage("en-US");
    await _flutterTts.setPitch(1.0);
    await _flutterTts.speak(text);
  }

  // Function to delete a question
  void _deleteQuestion(String question) {
    setState(() {
      _commonQuestions.remove(question);
      _filteredQuestions.remove(question);
    });
  }

  // Function to handle adding to favorites (dummy function)
  void _addToFavorites(String question) {
    // Logic to add the question to favorites (not implemented here)
    print("$question added to favorites!"); // Placeholder for favorite functionality
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Common Questions"),
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
              onChanged: _filterQuestions,
              decoration: InputDecoration(
                hintText: "Search for a question...",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            // List of filtered questions
            Expanded(
              child: ListView.builder(
                itemCount: _filteredQuestions.length,
                itemBuilder: (context, index) {
                  final question = _filteredQuestions[index];
                  return ListTile(
                    title: Text(question),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.speaker),
                          onPressed: () => _speak(question), // Text-to-Speech
                        ),
                        IconButton(
                          icon: const Icon(Icons.favorite),
                          onPressed: () => _addToFavorites(question), // Add to favorites
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _deleteQuestion(question), // Delete question
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            // Add new question option
            if (_filteredQuestions.contains("No results found: Add this question"))
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: ElevatedButton(
                  onPressed: () {
                    _addQuestion(_searchController.text);
                  },
                  child: const Text("Add this question"),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
