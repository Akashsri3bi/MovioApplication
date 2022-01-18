import 'package:flutter/material.dart';
import 'package:movies/auth_service.dart';
import 'package:movies/pages/home_page.dart';
import 'package:movies/pages/starter.dart';
import 'package:movies/user.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Creating a avariable of authService
    final authService = Provider.of<AuthService>(context);
    //returing a Stream builder to get a stream of users
    return StreamBuilder<Users?>(
        stream: authService.user,
        builder: (_, AsyncSnapshot<Users?> snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final Users? user = snapshot.data;
            return user == null ? LoginScreen() : const HomePage();
          } else {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}
