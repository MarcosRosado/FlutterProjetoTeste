
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../controllers/login_controller.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;

  void _handleLoginPressed() async {
    setState(() => _isLoading = true);
    bool success = await LoginCommand().run("anotheruser", "somepass");
    if (!success) {
      setState(() => _isLoading = false);
    } else {
      context.go('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _isLoading
            ? CircularProgressIndicator()
            : ElevatedButton(
          onPressed: _handleLoginPressed,
          child: Text("Login"),
        ),
      ),
    );
  }
}