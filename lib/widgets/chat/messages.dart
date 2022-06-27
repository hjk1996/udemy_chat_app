import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('chats').snapshots(),
      builder: (ctx, AsyncSnapshot chatSnapshot) {
        if (chatSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        final chatDocs = chatSnapshot.data.docs ?? [];

        return ListView.builder(
          itemCount: chatDocs.length,
          itemBuilder: (ctx, idx) {
            // 여기서 안됨 해결하셈
            print(json.decode(chatDocs[0]));
            return Text('hi');
          },
        );
      },
    );
  }
}
