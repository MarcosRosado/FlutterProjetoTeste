import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../authentication/view_models/auth_view_model.dart';
import '../view_models/user_posts_view_model.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = false;

  void _handleRefreshPressed() async {
    // Disable the RefreshBtn while the Command is running
    setState(() => _isLoading = true);
    // Run command
    if(context.read<AuthViewModel>().currentUser == null) {
      setState(() => _isLoading = false);
      return;
    }
    else{
      await context.read<UserPostsViewModel>().getPosts(context.read<AuthViewModel>().currentUser!);
    }
    // Re-enable refresh btn when command is done
    setState(() => _isLoading = false);
  }

  void _handleResetUserPressed() {
    setState(() => _isLoading = true);
    context.read<AuthViewModel>().currentUser = null;
    context.go('/authentication');
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final userPostsViewModel = context.watch<UserPostsViewModel>();
    // Read the userPosts property from the view model
    var userPosts = userPostsViewModel.userPosts;

    // alternatively you can use the select method to bind to a specific property
    // var userPosts = context.select<UserPostsModel, List<String>>((value) => value.userPosts);

    // Disable btn by removing listener when we're loading.
    void Function()? btnHandler = _isLoading ? null : _handleRefreshPressed;
    void Function()? btnHandlerResetUser = _isLoading ? null : _handleResetUserPressed;
    // Render list of post widgets
    var listPosts = userPosts.map((post) => Text(post)).toList();
    return Scaffold(
      body: Column(
        children: [
          Flexible(child: ListView(children: listPosts)),
          FilledButton(onPressed: btnHandler, child: Text("REFRESH")),
          FilledButton(onPressed: btnHandlerResetUser, child: Text("RESET_USER")),
        ],
      ),
    );
  }
}