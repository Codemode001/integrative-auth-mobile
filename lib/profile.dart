import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late String userEmail = '';
  late String userName = '';

  @override


  Future<void> fetchUserData() async {
    try {
      final response = await supabase.auth.currentUser;
      if (response == null) {
        throw 'User not authenticated';
      }
      final user = response;
      final userMetadata = response.userMetadata;
      if (user != null) {
        setState(() {
          userEmail = user.email!;
          userName = userMetadata != null ? userMetadata['displayName'] : ''; // Handle nullable user metadata
        });
      }
      print(userName);
    } catch (error) {
      print('Error fetching user data: $error');
    }
  }

  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> signOut() async {
    try {
      final response = await supabase.auth.signOut();
      Navigator.pushNamed(context, '/');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('User Signed Out!'),
        ),
      );
    } catch (error) {
      print('Sign out error: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Sign out failed. Please try again.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF15A9FF), Color(0xFFFF69B4)],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage('https://m.media-amazon.com/images/M/MV5BMTI5ODY5NTUzMF5BMl5BanBnXkFtZTcwOTAzNTIzMw@@._V1_.jpg'),
              radius: 50,
            ),
            SizedBox(height: 20),
            Text(
              userName ?? 'Loading...',
              style: TextStyle(
                color: Color(0xFF15A9FF),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              userEmail ?? 'Loading...',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: signOut,
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
