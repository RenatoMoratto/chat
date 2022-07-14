import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/services/auth/auth_service.dart';
import '../core/models/chat_user.dart';
import '../core/services/notification/chat_notification_service.dart';
import 'chat_page.dart';
import 'auth_page.dart';
import 'loading_page.dart';

class AuthOrAppPage extends StatelessWidget {
  const AuthOrAppPage({Key? key}) : super(key: key);

  Future<void> init(BuildContext context) async {
    await Firebase.initializeApp();
    // ignore: use_build_context_synchronously
    await Provider.of<ChatNotificationService>(
      context,
      listen: false,
    ).init();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: init(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingPage();
        }
        return StreamBuilder<ChatUser?>(
          stream: AuthService().userChanges,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingPage();
            }
            if (snapshot.hasData) {
              return const ChatPage();
            }
            return const AuthPage();
          },
        );
      },
    );
  }
}
