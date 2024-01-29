
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../main_page/view_models/user_posts_view_model.dart';
import '../view_models/auth_view_model.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  bool _isLoading = false;

  void _handleLoginPressed() async {
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
    final postsViewModel = Provider.of<UserPostsViewModel>(context, listen: false);

    setState(() => _isLoading = true);
    bool success = await authViewModel.login("anotheruser", "somepass");
    if (!success) {
      setState(() => _isLoading = false);
    } else {
      if(!mounted) return;
      postsViewModel.getPosts(authViewModel.currentUser!);
      context.go('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator()
            : ElevatedButton(
                onPressed: _handleLoginPressed,
                child: const Text("Login"),
            ),
      ),
    );
  }
}