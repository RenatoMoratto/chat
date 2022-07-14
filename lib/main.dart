import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'utils/app_routes.dart';
import 'core/services/notification/chat_notification_service.dart';
import 'pages/auth_or_app_page.dart';
import 'pages/chat_page.dart';
import 'pages/notification_page.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ChatNotificationService(),
        )
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          AppRoutes.authOrHome: (context) => const AuthOrAppPage(),
          AppRoutes.chat: (context) => const ChatPage(),
          AppRoutes.notifications: (context) => const NotificationPage(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
