import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'home_page.dart';
import 'lesson_page.dart';
import 'quiz_page.dart';
import 'profile_page.dart';
import 'settings_page.dart';
import 'login_page.dart';
import 'signup_page.dart';
import 'leaderboard_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Accounting App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
      routes: {
        '/home': (context) => const HomePage(),
        '/lesson': (context) => const LessonPage(),
        '/quiz': (context) => QuizPage(lessons: LessonPage.getLessons()), // Access _levels using the static method
        '/profile': (context) => const ProfilePage(),
        '/settings': (context) => const SettingsPage(),
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignupPage(),
        '/leaderboard': (context) => const LeaderboardPage(),
      },
    );
  }
}