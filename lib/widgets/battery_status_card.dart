import 'package:flutter/material.dart';

class BatteryStatusCard extends StatelessWidget {
  const BatteryStatusCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      margin: EdgeInsets.all(10),
      elevation: 3,
      child: SizedBox(
        width: 180,
        height: 100, // Adjust the width as needed
        child: ListTile(
          leading: Icon(Icons.battery_std),
          title: Text('Battery Status'),
          subtitle: Text('Battery: 80%'),
          // You can add more widgets here based on your requirements
        ),
      ),
    );
  }
}