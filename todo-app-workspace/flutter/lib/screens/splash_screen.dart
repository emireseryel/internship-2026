import 'package:flutter/material.dart';
import 'package:flutterproject/state/auth_notifier.dart';
import 'package:flutterproject/screens/auth/login_screen.dart';
import 'package:flutterproject/screens/task/task_list_screen.dart';

class SplashScreen extends StatefulWidget {
  final AuthNotifier authNotifier;

  const SplashScreen({super.key, required this.authNotifier});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    final isLoggedIn = await widget.authNotifier.checkAuthStatus();
    if (!mounted) return;

    if (isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => TaskListScreen(authNotifier: widget.authNotifier),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => LoginScreen(authNotifier: widget.authNotifier),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}