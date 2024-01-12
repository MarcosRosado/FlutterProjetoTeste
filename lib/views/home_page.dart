import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../commands/refresh_posts_command.dart';
import '../models/app_model.dart';
import '../models/user_model.dart';

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
    if(context.read<AppModel>().currentUser == null) {
      setState(() => _isLoading = false);
      return;
    }
    else{
      await RefreshPostsCommand().exec(context.read<AppModel>().currentUser!);
    }
    // Re-enable refresh btn when command is done
    setState(() => _isLoading = false);
  }

  void _handleResetUserPressed() async {
    setState(() => _isLoading = true);
    context.read<AppModel>().currentUser = null;
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    // Bind to UserModel.userPosts
    var userPosts = context.select<UserModel, List<String>>((value) => value.userPosts);
    // Disable btn by removing listener when we're loading.
    void Function()? btnHandler = _isLoading ? null : _handleRefreshPressed;
    void Function()? btnHandlerResetUser = _isLoading ? null : _handleResetUserPressed;
    // Render list of widgets
    var listWidgets = userPosts.map((post) => Text(post)).toList();
    return Scaffold(
      body: Column(
        children: [
          Flexible(child: ListView(children: listWidgets)),
          FilledButton(onPressed: btnHandler, child: Text("REFRESH")),
          FilledButton(onPressed: btnHandlerResetUser, child: Text("RESET_USER")),
        ],
      ),
    );
  }
}