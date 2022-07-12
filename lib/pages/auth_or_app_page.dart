import 'package:flutter/material.dart';

import '../core/services/auth/auth_mock_service.dart';
import '../core/models/chat_user.dart';
import 'chat_page.dart';
import 'auth_page.dart';
import 'loading_page.dart';

class AuthOrAppPage extends StatelessWidget {
  const AuthOrAppPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<ChatUser?>(
        stream: AuthMockService().userChanges,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingPage();
          }
          if (snapshot.hasData) {
            return const ChatPage();
          }
          return const AuthPage();
        },
      ),
    );
  }
}
