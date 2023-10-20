import 'package:flutter/material.dart';
import 'package:tracking_app/widgets/homePage/community_message.dart';
import 'package:tracking_app/widgets/homePage/community_new_messages.dart';

class CommunityMessageCard extends StatelessWidget {
  const CommunityMessageCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 5,
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: const SizedBox(
        width: double.infinity,
        height: 480,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Community Messages',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: CommunityMessages(),
                    ),
                    SizedBox(height: 10),
                    NewCommunityMessage(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
