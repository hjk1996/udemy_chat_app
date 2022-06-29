import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({Key? key}) : super(key: key);

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _messageController = TextEditingController();

  void _sendMessage() async {
    FocusScope.of(context).unfocus();

    final userId = FirebaseAuth.instance.currentUser!.uid;
    final userInfo =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();

    FirebaseFirestore.instance
        .collection('/chats/ou2HF6fAI8dFFjyQ5UZj/messages')
        .add({
      'text': _messageController.text,
      'createdAt': Timestamp.now(),
      'userId': userId,
      'username': userInfo['username']
    });
    _messageController.clear();
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(label: Text('Send a message..')),
              controller: _messageController,
              onChanged: (_) {
                setState(() {});
              },
            ),
          ),
          IconButton(
            onPressed: _messageController.text.isEmpty ? null : _sendMessage,
            icon: Icon(Icons.send),
          )
        ],
      ),
    );
  }
}
