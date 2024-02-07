

import 'package:flutter/material.dart';
import 'package:flutter_projects/common/models/user/user_session.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userSession = context.read<UserSession>();

    return Scaffold(
      body: FutureBuilder(
        future: Future.wait([
          userSession.init(), //initialize the userSession to be used by the rest of the app
        ]),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // return a loading widget while waiting for the future
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            // return the appropriate screen depending on the snapshot data
            var userData = snapshot.data?[0];
            print(snapshot);
            if (userData == null) {
              // no user data, navigate to login screen
              Future.delayed(const Duration(seconds: 2), () {
                context.go('/authentication');
              });
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              // user data available, navigate to main screen
              Future.delayed(const Duration(seconds: 2), () {
                context.go('/home');
              });
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }
        },
      ),
    );
  }

}