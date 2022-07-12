import 'package:chat/core/models/chat_message.dart';
import 'package:flutter/material.dart';

import '../core/services/auth/auth_service.dart';
import '../core/services/chat/chat_service.dart';
import 'message_bubble.dart';

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentUser = AuthService().currentUser;

    return StreamBuilder<List<ChatMessage>>(
      stream: ChatService().messagesStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Sem Dados. Vamos conversar?'));
        }
        final msgs = snapshot.data!;
        return ListView.builder(
          reverse: true,
          itemCount: msgs.length,
          itemBuilder: (context, index) => MessageBuble(
            key: ValueKey(msgs[index].id),
            message: msgs[index],
            belongsToCurrentUser: currentUser?.id == msgs[index].userId,
          ),
        );
      },
    );
  }
}
