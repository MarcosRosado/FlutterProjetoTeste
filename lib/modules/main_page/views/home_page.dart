import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../authentication/view_models/auth_view_model.dart';
import '../view_models/user_posts_view_model.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  bool _isLoading = false;


  void _handleRefreshPressed() async {
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
    final postsViewModel = Provider.of<UserPostsViewModel>(context, listen: false);
    // Disable the RefreshBtn while the Command is running
    setState(() => _isLoading = true);
    // Run command
    if(authViewModel.currentUser == null) {
      setState(() => _isLoading = false);
      return;
    }
    else{
      await postsViewModel.getPosts(authViewModel.currentUser!);
    }
    // Re-enable refresh btn when command is done
    setState(() => _isLoading = false);
  }

  void _handleResetUserPressed() {
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);

    setState(() => _isLoading = true);
    authViewModel.currentUser = null;
    context.go('/authentication');
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final postsViewModel = Provider.of<UserPostsViewModel>(context);

    // Read the userPosts property from the view model
    var userPosts = postsViewModel.userPosts;

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