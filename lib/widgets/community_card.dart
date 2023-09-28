import 'package:flutter/material.dart';

class CommunityCard extends StatelessWidget {
  const CommunityCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      margin: EdgeInsets.all(10),
      elevation: 3,
      child: SizedBox(
        width: 400, // Adjust the width as needed
        height: 400, // Adjust the height as needed
        child: ListTile(
          leading: Icon(Icons.group),
          title: Text('Community'),
          subtitle: Text('Join the community and share experiences'),
          // You can add more widgets here based on your requirements
        ),
      ),
    );
  }
}
