import 'package:flutter/material.dart';

class RecentActivityCard extends StatelessWidget {
  const RecentActivityCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      margin: EdgeInsets.all(10),
      elevation: 3,
      child: SizedBox(
        width: 180,
        height: 100, // Adjust the width as needed
        child: ListTile(
          leading: Icon(Icons.recent_actors),
          title: Text('Recent Activity'),
          subtitle: Text('Activity: 3 new events'),
          // You can add more widgets here based on your requirements
        ),
      ),
    );
  }
}
