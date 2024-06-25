import 'package:flutter/material.dart';
import 'lesson_page.dart';
import 'profile_page.dart';
import 'settings_page.dart';
import 'leaderboard_page.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  static final List<Widget> _pages = <Widget>[
    const HomeScreen(),
    const LessonPage(), // Use LessonPage to handle quiz navigation
    const LeaderboardPage(),
    const ProfilePage(),
    const SettingsPage(),
  ];
  late AnimationController _controller;
  late Animation<double> _animation;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _controller.forward(from: 0.0);
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accounting App',style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.purple[900], // Deeper purple
        elevation: 0, // Remove the shadow
      ),
      body: FadeTransition(
        opacity: _animation,
        child: Center(
          child: _pages.elementAt(_selectedIndex),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.black),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book, color: Colors.black),
            label: 'Lessons',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.leaderboard, color: Colors.black),
            label: 'Leaderboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.black),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings, color: Colors.black),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepPurpleAccent,
        unselectedItemColor: Colors.black,
        backgroundColor: Colors.purple[900],
        showUnselectedLabels: true, // Show labels for unselected items
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0), // More padding for breathing room
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Learn Accounting',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Master the fundamentals of accounting with our interactive lessons and quizzes.',
            style: TextStyle(
              fontSize: 18,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 40),
          // Start Learning Card
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/lesson');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF7F3B8B),
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
              textStyle: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white, // White text on purple button
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: const Text('Start Learning',style: TextStyle(color: Colors.white),),
          ),
          const SizedBox(height: 20),
          // Take a Quiz Card
          ElevatedButton(
            onPressed: () {
              // Navigate to the QuizPage route
              Navigator.pushNamed(context, '/quiz');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF7F3B8B),
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
              textStyle: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white, // White text on purple button
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: const Text('Take a Quiz',style: TextStyle(color: Colors.white),),
          ),
        ],
      ),
    );
  }
}