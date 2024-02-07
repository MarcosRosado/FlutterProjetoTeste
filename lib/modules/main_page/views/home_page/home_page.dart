import 'package:flutter/material.dart';
import 'package:flutter_projects/common/widgets/input/dropdownButton2.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../view_models/user_posts_view_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  bool _isLoading = false;

  @override
  void initState() {
    final postsViewModel = context.read<UserPostsViewModel>();
    super.initState();
    postsViewModel.getPosts();
  }

  void _handleRefreshPressed() async {
    final postsViewModel = context.read<UserPostsViewModel>();
    // Disable the RefreshBtn while the Command is running
    setState(() => _isLoading = true);
    // Run command
    if (postsViewModel.currentUser == null) {
      setState(() => _isLoading = false);
      return;
    } else {
      await postsViewModel.getPosts();
    }
    // Re-enable refresh btn when command is done
    setState(() => _isLoading = false);
  }

  void _handleBottomNavNavigation() async {
    context.go('/page1');
  }

  void _handleResetUserPressed() {
    final postsViewModel = context.read<UserPostsViewModel>();

    setState(() => _isLoading = true);
    postsViewModel.signOut();
    context.go('/authentication');
    setState(() => _isLoading = false);
  }

  void onChanged(String? value) {
    setState(() {
      dropdownValue = value;
    });
  }

  String? dropdownValue;

  //generate list with 20 random items
  List<String> options = List.generate(20, (index) => "Item $index");

  @override
  Widget build(BuildContext context) {
    // viewmodel initialization can be replaced by  Provider.of<UserPostsViewModel>(context);
    final postsViewModel = context.watch<UserPostsViewModel>();

    // Read the userPosts property from the view model
    var userPosts = postsViewModel.userPosts;

    // alternatively you can use the select method to bind to a specific property
    // var userPosts = context.select<UserPostsModel, List<String>>((value) => value.userPosts);

    // Disable btn by removing listener when we're loading.
    void Function()? btnHandler = _isLoading ? null : _handleRefreshPressed;
    void Function()? btnBottomNav = _isLoading ? null : _handleBottomNavNavigation;
    void Function()? btnHandlerResetUser =
        _isLoading ? null : _handleResetUserPressed;
    // Render list of post widgets
    var listPosts = userPosts.map((post) => Text(post)).toList();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            CustomDropdown(
                title: "Título",
                dropdownWidth: double.infinity,
                placeholder: "Selecione um item",
                onChanged: onChanged,
                dropdownValue: dropdownValue,
                dropdownHeight: 200,
                options: options),
            Flexible(child: ListView(children: listPosts)),
            FilledButton(onPressed: btnHandler, child: const Text("REFRESH")),
            FilledButton(onPressed: btnBottomNav, child: const Text("Go to bottom navigation bar")),
            FilledButton(
                onPressed: btnHandlerResetUser,
                child: const Text("RESET_USER")),

          ],
        ),
      ),
    );
  }
}
