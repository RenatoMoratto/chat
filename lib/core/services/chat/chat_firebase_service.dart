import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/chat_message.dart';
import '../../models/chat_user.dart';
import 'chat_service.dart';

class ChatFirebaseService implements ChatService {
  @override
  Stream<List<ChatMessage>> messagesStream() {
    return const Stream<List<ChatMessage>>.empty();
  }

  @override
  Future<ChatMessage?> save(String text, ChatUser user) async {
    final store = FirebaseFirestore.instance;

    final msg = ChatMessage(
      id: '',
      text: text,
      createdAt: DateTime.now(),
      userId: user.id,
      userName: user.name,
      userImageURL: user.imageURL,
    );

    final docRef = await store
        .collection('chat')
        .withConverter(
          fromFirestore: _fromFirestore,
          toFirestore: _toFirestore,
        )
        .add(msg);

    final snapshot = await docRef.get();
    return snapshot.data()!;
  }

  ChatMessage _fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    return ChatMessage(
      id: snapshot.id,
      text: snapshot['text'],
      createdAt: DateTime.parse(snapshot['createdAt']),
      userId: snapshot['userId'],
      userName: snapshot['userName'],
      userImageURL: snapshot['userImageURL'],
    );
  }

  Map<String, dynamic> _toFirestore(ChatMessage msg, SetOptions? options) {
    return {
      'text': msg.text,
      'createdAt': msg.createdAt.toIso8601String(),
      'userId': msg.userId,
      'userName': msg.userName,
      'userImageURL': msg.userImageURL
    };
  }
}
