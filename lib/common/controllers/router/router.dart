import 'package:flutter/material.dart';
import 'package:flutter_projects/common/controllers/router/router_animation.dart';
import 'package:flutter_projects/modules/authentication/views/login_page.dart';
import 'package:flutter_projects/modules/main_page/views/home_page.dart';
import 'package:go_router/go_router.dart';

/// This handles '/' and '/details'.
final router = GoRouter(
  initialLocation: '/authentication',
  routes: [
    /**
     * GoRoute can have nested routes.
     * this can be done by adding another GoRoute inside the routes optional property of the GoRoute.
     * navigation can be done using the context.go() method. if a route is nested you can access it from the
     * outside using context.go('/routeName/nestedRouteName')
     * or go back within the nested route using context.go('../anotherNestedRouteName'), or using the full path.
     */
    GoRoute(
      path: '/authentication',
      pageBuilder: (context, state) => buildPageWithoutTransition<void>(
        context: context,
        state: state,
        child: Scaffold(
          appBar: AppBar(title: const Text('Login Screen')),
          body: const LoginPage(),
        ),
      ),
    ),
    GoRoute(
      path: '/home',
      pageBuilder: (context, state) => buildPageWithoutTransition<void>(
        context: context,
        state: state,
        child: Scaffold(
          appBar: AppBar(title: const Text('Home Screen')),
          body: const HomePage(),
        ),
      ),
    ),
  ],
);