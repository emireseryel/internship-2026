import 'package:flutter/material.dart';
import 'package:flutterproject/screens/splash_screen.dart';
import 'package:flutterproject/state/auth_notifier.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authNotifier = AuthNotifier();

    return MaterialApp(
      title: 'Todo App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SplashScreen(authNotifier: authNotifier),
    );
  }
}