import 'package:flutter/material.dart';
import 'package:flutter_firestore_chatting_practice/pages/login_page.dart';

import 'package:flutter_firestore_chatting_practice/pages/splash_page.dart';
import 'package:flutter_firestore_chatting_practice/providers/authentication.dart';
import 'package:flutter_firestore_chatting_practice/services/navigation_services.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(SplashPage(
    key: UniqueKey(),
    onInitalizationComplete: () {
      runApp(
        MainApp(),
      );
    },
  ));
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthenticationProvider>(
          create: (context) {
            return AuthenticationProvider();
          },
        )
      ],
      child: MaterialApp(
        title: 'GgamfChat',
        theme: ThemeData(
          backgroundColor: const Color.fromRGBO(36, 35, 49, 1.0),
          scaffoldBackgroundColor: const Color.fromRGBO(36, 35, 49, 1.0),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: const Color.fromRGBO(30, 29, 37, 1.0),
          ),
        ),
        navigatorKey: NavigationService.navigatorKey,
        initialRoute: '/login',
        routes: {
          '/login': (BuildContext context) => LoginPage(),
        },
      ),
    );
  }
}
