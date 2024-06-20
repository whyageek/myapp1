import 'package:flutter/material.dart';

class SelectionPage extends StatelessWidget {
  final List<String> cigaretteTypes = ['Type A', 'Type B', 'Type C']; // Replace with your actual types

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Cigarette Type'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: cigaretteTypes.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(cigaretteTypes[index]),
            onTap: () {
              // Implement logic to save selected type to Firebase or local storage
              Navigator.pushReplacementNamed(context, '/dashboard');
            },
          );
        },
      ),
    );
  }
}
