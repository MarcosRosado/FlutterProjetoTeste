import 'package:flutter/material.dart';
import 'package:flutter_projects/common/models/providers/user_provider.dart';
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
         * Provider creates an instance of the service and makes it available to the rest of the app;
         * This can also serve as a singleton, meaning that the same instance will be used throughout the app;
         * In the case of UserProvider it is a storage for the current user.
         */
        Provider(create: (c) => AuthService()),
        Provider(create: (c) => PostService()),
        Provider(create: (c) => UserProvider()),


        /**
         * ChangeNotifierProxyProvider creates an instance of the viewModel and injects the previously provided dependencies
         * into the viewModel. It also listens to the provided dependencies and updates the viewModel when they change.
         *
         * NOTE: the operator ?? AuthViewModel(authService: authService) is a null check. If the viewModel is null, create a new one,
         * otherwise use the existing one and apply the update to it.
         *
         * another way of accessing the context is using the Provider.of<AuthService>(context, listen:false) method
         */
        ChangeNotifierProxyProvider2<AuthService, UserProvider, AuthViewModel>(
            create: (c) => AuthViewModel(authService: c.read<AuthService>(), userService: c.read<UserProvider>()),
            update: (c, authService, userService, authViewModel) => authViewModel ?? AuthViewModel(authService: authService, userService: userService)..update(authService: authService, userService: userService),
        ),

        //Main Page - Posts
        ChangeNotifierProxyProvider2<PostService, UserProvider, UserPostsViewModel>(
            create: (c) => UserPostsViewModel(postService: c.read<PostService>(), userService: c.read<UserProvider>()),
            update: (c, postService, userProvider, userPostsViewModel) => userPostsViewModel ?? UserPostsViewModel(postService: postService, userService: userProvider)..update(postService: postService, userService: userProvider),
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