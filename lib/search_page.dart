import 'package:flutter/material.dart';
import 'lesson_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<String> _searchResults = [];

  void _search(String query) {
    // Dummy data for example
    final List<String> allLessonsAndQuizzes = [
      'Introduction to Accounting',
      'Financial Statements',
      'Accounting Principles',
      'Quiz: Basic Accounting',
    ];

    setState(() {
      _searchResults = allLessonsAndQuizzes
          .where((element) => element.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    _search(_searchController.text);
                  },
                ),
              ),
              onSubmitted: _search,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _searchResults.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_searchResults[index]),
                    onTap: () {
                      // Navigate to the respective lesson or quiz page
                      // This is a placeholder for actual navigation logic
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LessonPage(),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
