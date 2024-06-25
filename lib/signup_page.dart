// signup_page.dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io'; // Import for File handling
import 'package:google_sign_in/google_sign_in.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? _profilePictureUrl;
  final ImagePicker _picker = ImagePicker();
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  void _signup() async {
    try {
      print('Starting signup process...');
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      User? user = userCredential.user;

      if (user != null) {
        print('User created successfully in Firebase Auth!');
        print('User UID: ${user.uid}');

        // Update display name and profile picture
        await user.updateDisplayName(_nameController.text);
        await user.updatePhotoURL(_profilePictureUrl);

        // Create a user document in Firestore
        await _firestore.collection('users').doc(user.uid).set({
          'displayName': _nameController.text,
          'email': _emailController.text,
          'photoURL': _profilePictureUrl ?? 'https://via.placeholder.com/150', // Default image if none uploaded
          'xp': 0, // Initialize XP to 0
        }).then((value) {
          print('User document added successfully to Firestore!');
          Navigator.pushReplacementNamed(context, '/home');
        }).catchError((error) {
          print('Error adding user document to Firestore: ${error.toString()}');
        });

      } else {
        print('User creation failed in Firebase Auth!');
      }
    } catch (e) {
      print('Signup error: ${e.toString()}');
      // Handle the error, display a message to the user, etc.
    }
  }

  Future<void> _getImageFromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _profilePictureUrl = image.path;
      });
    }
  }

  Future<void> _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        await _auth.signInWithCredential(credential);
        print('Signed in with Google!');

        // Update user information in Firestore
        User? user = _auth.currentUser;
        if (user != null) {
          await _firestore.collection('users').doc(user.uid).set({
            'displayName': user.displayName,
            'email': user.email,
            'photoURL': user.photoURL,
            'xp': 0,
          });
          print('User information updated in Firestore!');
        }

        Navigator.pushReplacementNamed(context, '/home');
      }
    } catch (e) {
      print('Error signing in with Google: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up',style: TextStyle(color: Colors.white),),
        backgroundColor: const Color(0xFF4B188C),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 20),
            if (_profilePictureUrl != null)
              Image.file(
                File(_profilePictureUrl!),
                height: 100,
                width: 100,
              ),
            ElevatedButton(
              onPressed: _getImageFromGallery,
              child: const Text('Choose Profile Picture'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _signup,
              child: const Text('Sign Up with Email'),
            ),
            ElevatedButton(
              onPressed: _signInWithGoogle,
              child: const Text('Sign Up with Google'),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              child: const Text('Already have an account? Login'),
            ),
          ],
        ),
      ),
    );
  }
}