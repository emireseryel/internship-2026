import 'package:flutter/material.dart';
import 'package:flutterproject/screens/auth/register_screen.dart';
import 'package:flutterproject/screens/task/task_list_screen.dart';
import 'package:flutterproject/state/auth_notifier.dart';

class LoginScreen extends StatefulWidget {
  final AuthNotifier authNotifier;

  const LoginScreen({super.key, required this.authNotifier});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  final ValueNotifier<bool> _isPasswordVisible = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _isPasswordVisible.dispose(); 
    super.dispose();
  }

  Future<void> _handleLogin() async { 
    if (!_formKey.currentState!.validate()) return;

    try {
      await widget.authNotifier.login(
        _emailController.text.trim(),
        _passwordController.text,
      );

      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => TaskListScreen(authNotifier: widget.authNotifier),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      final message = e.toString().replaceAll('Exception: ', '');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your email address.';
                      }
                      if (!value.contains('@')) {
                        return 'Enter a valid email address.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
          
                  ValueListenableBuilder<bool>(
                    valueListenable: _isPasswordVisible,
                    builder: (context, isVisible, child) {
                      return TextFormField(
                        controller: _passwordController,
                        obscureText: !isVisible,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          prefixIcon: const Icon(Icons.lock),
                          border: const OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: Icon(
                              isVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                                _isPasswordVisible.value = !_isPasswordVisible.value;
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          if (value.length < 6) {
                            return 'The password must be at least 6 characters.';
                          }
                          return null;
                        },
                      );
                    }
                  ),
                  const SizedBox(height: 24),
          
                  ValueListenableBuilder<bool>(
                    valueListenable: widget.authNotifier.isLoading,
                    builder: (context, isLoading, child) {
                      return ElevatedButton(
                        onPressed: isLoading ? null : _handleLogin,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: isLoading
                            ? const CircularProgressIndicator()
                            : const Text('Login', style: TextStyle(fontSize: 16)),
                      );
                    },
                  ),
                  const SizedBox(height: 12),
          
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => RegisterScreen(authNotifier: widget.authNotifier),
                        ),
                      );
                    },
                    child: const Text("Don't have an account? Sign up."),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}