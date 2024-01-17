
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../main_page/view_models/user_posts_view_model.dart';
import '../view_models/auth_view_model.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;

  void _handleLoginPressed() async {
    setState(() => _isLoading = true);
    bool success = await context.read<AuthViewModel>().login("anotheruser", "somepass");
    if (!success) {
      setState(() => _isLoading = false);
    } else {
      context.read<UserPostsViewModel>().getPosts(context.read<AuthViewModel>().currentUser!);
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