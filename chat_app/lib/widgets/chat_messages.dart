import 'package:chat_app/widgets/bubble_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatMessages extends StatelessWidget {
  const ChatMessages({super.key});

  @override
  Widget build(BuildContext context) {
    final authtenticatedUser = FirebaseAuth.instance.currentUser!;

    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (ctx, chatSnapshop) {
        if (chatSnapshop.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!chatSnapshop.hasData || chatSnapshop.data!.docs.isEmpty) {
          return const Center(child: Text('No messages found.'));
        }

        if (chatSnapshop.hasError) {
          return const Center(child: Text('Something went wrong...'));
        }

        final loadedMessage = chatSnapshop.data!.docs;

        return ListView.builder(
          padding: const EdgeInsets.only(bottom: 40, left: 13, right: 13),
          reverse: true,
          itemCount: loadedMessage.length,
          itemBuilder: ((context, index) {
            final chatMessage = loadedMessage[index].data();
            final nextChatMessage = index + 1 < loadedMessage.length
                ? loadedMessage[index + 1].data()
                : null;

            final currentMessageUserId = chatMessage['userId'];
            final nextMessageUserId = nextChatMessage != null
                ? nextChatMessage['userId']
                : null;

            final nextUserIdSame = currentMessageUserId == nextMessageUserId;

            if (nextUserIdSame) {
              return MessageBubble.next(
                message: chatMessage['text'],
                isMe: authtenticatedUser.uid == currentMessageUserId,
              );
            } else {
              return MessageBubble.first(
                username: chatMessage['username'],
                message: chatMessage['text'],
                isMe: authtenticatedUser.uid == currentMessageUserId,
              );
            }
          }),
        );
      },
    );
  }
}
