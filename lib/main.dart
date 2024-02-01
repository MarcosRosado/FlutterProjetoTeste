import 'package:flutter/material.dart';
import 'package:flutter_projects/common/styles/theme.dart';
import 'package:flutter_projects/common/controllers/router/router.dart';
import 'package:flutter_projects/common/models/services/authentication/auth_service.dart';
import 'package:flutter_projects/common/models/services/main_page/posts_service.dart';
import 'package:provider/provider.dart';

import 'modules/authentication/view_models/auth_view_model.dart';
import 'modules/main_page/view_models/user_posts_view_model.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext _) {
    /**
     * Dependency injection for dart
     */
    return MultiProvider(
      providers: [
        /**
         * Provider creates an instance of the service and makes it available to the rest of the app.
         */
        Provider(create: (c) => AuthService()),
        Provider(create: (c) => PostService()),


        /**
         * ChangeNotifierProxyProvider creates an instance of the viewModel and injects the previously provided dependencies
         * into the viewModel. It also listens to the provided dependencies and updates the viewModel when they change.
         *
         * NOTE: the operator ?? AuthViewModel(authService: authService) is a null check. If the viewModel is null, create a new one,
         * otherwise use the existing one and apply the update to it.
         *
         * another way of accessing the context is using the Provider.of<AuthService>(context, listen:false) method
         */
        ChangeNotifierProxyProvider<AuthService, AuthViewModel>(
            create: (c) => AuthViewModel(authService: c.read<AuthService>()),
            update: (c, authService, authViewModel) => authViewModel ?? AuthViewModel(authService: authService)..update(authService: authService),
        ),

        //Main Page - Posts
        ChangeNotifierProxyProvider<PostService, UserPostsViewModel>(
            create: (c) => UserPostsViewModel(postService: c.read<PostService>()),
            update: (c, postService, userPostsViewModel) => userPostsViewModel ?? UserPostsViewModel(postService: postService)..update(postService: postService),
        ),

      ],
      child: Builder(builder: (context) {
        return MaterialApp.router(
          routerConfig: router,
          theme: defaultTheme,
        );
      }),
    );
  }
}