import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewCommunityMessage extends StatefulWidget {
  const NewCommunityMessage({super.key});

  @override
  State<NewCommunityMessage> createState() {
    return _NewCommunityMessageState();
  }
}

class _NewCommunityMessageState extends State<NewCommunityMessage> {
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _submitMessage() async {
    final enteredMessage = _messageController.text;

    if (enteredMessage.trim().isEmpty) {
      return;
    }
    FocusScope.of(context).unfocus();
    _messageController.clear();

    final user = FirebaseAuth.instance.currentUser!;

    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    FirebaseFirestore.instance.collection('communityChat').add({
      'text': enteredMessage,
      'CreatedAt': Timestamp.now(),
      'userId': user.uid,
      'userName': userData.data()!['First Name'],
      'userImage': userData.data()!['image_Url'],
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              textCapitalization: TextCapitalization.sentences,
              autocorrect: true,
              enableSuggestions: true,

              decoration: InputDecoration(
                fillColor: Colors.grey.shade200,
                filled: true,
                hintText: 'Send message',
                hintStyle: const TextStyle(
                    color: Color.fromARGB(255, 71, 233, 133), fontSize: 12),
              ),
              // decoration: const InputDecoration(

              // ),
            ),
          ),
          IconButton(
            onPressed: _submitMessage,
            color: const Color.fromARGB(255, 71, 233, 133),
            icon: const Icon(Icons.send),
          ),
        ],
      ),
    );
  }
}
