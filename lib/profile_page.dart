import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final User? user = FirebaseAuth.instance.currentUser;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _photoUrlController = TextEditingController();
  final CollectionReference usersCollection =
  FirebaseFirestore.instance.collection('users');
  final CollectionReference progressCollection =
  FirebaseFirestore.instance.collection('progress');

  @override
  void initState() {
    super.initState();
    _nameController.text = user?.displayName ?? '';
    _photoUrlController.text = user?.photoURL ?? '';
  }

  Future<void> _updateProfile() async {
    try {
      await user?.updateDisplayName(_nameController.text);
      await user?.updatePhotoURL(_photoUrlController.text);
      await user?.reload();
      await usersCollection
          .doc(user?.uid)
          .update({'displayName': _nameController.text});
      setState(() {});
    } catch (e) {
      print(e.toString());
    }
  }

  Widget _buildLeaderboardSection() {
    return StreamBuilder<QuerySnapshot>(
      stream: usersCollection
          .orderBy('xp', descending: true)
          .snapshots(), // Order by XP
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text('Error fetching data'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final userDocs = snapshot.data!.docs;
        final currentUserIndex = userDocs.indexWhere(
                (doc) => doc.id == user?.uid); // Find user's position

        if (currentUserIndex == -1) {
          return const Text('User not found in leaderboard');
        }

        int startIndex =
            currentUserIndex - 2; // Start 2 positions before user
        int endIndex = currentUserIndex + 2; // End 2 positions after user
        // Adjust start and end indices to stay within bounds
        if (startIndex < 0) startIndex = 0;
        if (endIndex >= userDocs.length) endIndex = userDocs.length - 1;

        return ListView.builder(
          shrinkWrap: true, // Prevent ListView from expanding unnecessarily
          physics: const NeverScrollableScrollPhysics(), // Disable scrolling
          itemCount: endIndex - startIndex + 1,
          itemBuilder: (context, index) {
            final userDoc = userDocs[startIndex + index];
            final userName = userDoc.get('displayName') ?? 'Unknown';
            final xp = userDoc.get('xp') ?? 0;
            return ListTile(
              leading: Text((startIndex + index + 1).toString()),
              title: Text(userName),
              trailing: Text('$xp XP'),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile',style: TextStyle(color: Colors.white),),
        backgroundColor: Color(0xFF7F3B8B),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit,color: Colors.white,),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Edit Profile'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          controller: _nameController,
                          decoration:
                          const InputDecoration(labelText: 'Display Name'),
                        ),
                        TextFormField(
                          controller: _photoUrlController,
                          decoration: const InputDecoration(labelText: 'Photo URL'),
                        ),
                        ElevatedButton(
                          onPressed: _updateProfile,
                          child: const Text('Update'),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(user?.photoURL ??
                    'https://via.placeholder.com/150'),
                onBackgroundImageError: (exception, stackTrace) {
                  setState(() {
                    user?.updatePhotoURL('https://via.placeholder.com/150');
                  });
                },
              ),
              const SizedBox(height: 20),
              Text(
                user?.displayName ?? 'No Display Name',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              // Show the leaderboard
              const SizedBox(height: 20),
              const Text(
                'Leaderboard',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              _buildLeaderboardSection(),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushReplacementNamed(context, '/login');
                },
                child: const Text('Logout'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}