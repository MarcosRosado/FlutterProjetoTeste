import 'package:flutter/material.dart';
import 'package:flutter_projects/common/controllers/router/router_animation.dart';
import 'package:flutter_projects/modules/authentication/views/login_page.dart';
import 'package:flutter_projects/modules/authentication/views/splash_screen.dart';
import 'package:flutter_projects/modules/main_page/views/home_page/home_page.dart';
import 'package:flutter_projects/modules/main_page/views/bottom_navigation_screens/root_screen.dart';
import 'package:go_router/go_router.dart';

import '../../../modules/main_page/views/bottom_navigation_screens/details_screen.dart';
import '../../../modules/main_page/widgets/scaffold_with_nested_navigation.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorNav1Key = GlobalKey<NavigatorState>();
final _shellNavigatorNav2Key = GlobalKey<NavigatorState>();

/// This handles '/' and '/details'.
final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/splash',
  routes: [
    /**
     * StatefulShellRoute is a route that can have multiple branches, each branch can have its own navigatorKey.
     * This is useful when you want to have a bottom navigation bar, or a navigation drawer with multiple navigators.
     *
     * In this example the StatefulShellRoute has 2 branches, each branch has a nested page.
     * the scaffoldWithNestedNavigation is a custom widget that has a bottom navigation, it takes route from the
     * navigator shell and shows the current route as the body of the scaffold.
     */
    StatefulShellRoute.indexedStack(
        builder: (context, state, child) {
          return ScaffoldWithNestedNavigation(navigationShell: child);
        },
        branches:
        [
          /**
           * StatefulShellBranch is a branch of a StatefulShellRoute, it has a navigatorKey and a list of routes.
           * Routes can be nested, and can be accessed using the context.go() methods or the context.goBranch() to switch between branches.
           * Routes can further be nested inside each other, and can be accessed using the context.go() method.
           */
          StatefulShellBranch(
            navigatorKey: _shellNavigatorNav1Key,
            routes: [
              GoRoute(
                path: '/page1',
                pageBuilder: (context, state) => buildPageWithoutTransition<void>(
                  context: context,
                  state: state,
                  child: RootScreen(label: "Page1", detailsPath: "/page1/details"),
                ),
                routes: [
                  GoRoute(
                    path: 'details',
                    pageBuilder: (context, state) => buildPageWithoutTransition<void>(
                      context: context,
                      state: state,
                      child: DetailsScreen(label: 'Page1 details'),
                    ),
                  ),
                ]
              ),
            ]
          ),
          StatefulShellBranch(
              navigatorKey: _shellNavigatorNav2Key,
              routes: [
                GoRoute(
                    path: '/page2',
                    pageBuilder: (context, state) => buildPageWithoutTransition<void>(
                      context: context,
                      state: state,
                      child: RootScreen(label: "Page2", detailsPath: "/page2/details"),
                    ),
                    routes: [
                      GoRoute(
                        path: 'details',
                        pageBuilder: (context, state) => buildPageWithoutTransition<void>(
                          context: context,
                          state: state,
                          child: DetailsScreen(label: 'Page2 details'),
                        ),
                      ),
                    ]
                ),
              ]
          ),

        ],
    ),
    /**
     * GoRoute can have nested routes.
     * this can be done by adding another GoRoute inside the routes optional property of the GoRoute.
     * navigation can be done using the context.go() method. if a route is nested you can access it from the
     * outside using context.go('/routeName/nestedRouteName')
     * or go back within the nested route using context.go('../anotherNestedRouteName'), or using the full path.
     */
    GoRoute(
      path: '/splash',
      pageBuilder: (context, state) => buildPageWithoutTransition<void>(
        context: context,
        state: state,
        child: const SplashScreen(),
      ),
    ),
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