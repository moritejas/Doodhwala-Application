import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      appBar: AppBar(
        title: const Text('Profile Page',style: TextStyle(
            // color: Colors.deepPurple.shade50
        ),),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body:  const Center(
        child: Text(
          'Profile Page',
          style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color:Colors.white,),
        ),
      ),
    );
  }
}
