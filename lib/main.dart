import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:movies/auth_service.dart';
import 'package:movies/pages/home_page.dart';
import 'package:movies/pages/movie_list.dart';
import 'package:movies/pages/starter.dart';
import 'package:movies/routes.dart';
import 'package:movies/wrapper.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyAqfLV208nqVASSHSxKzTiQ4EVZ87YLt84",
          appId: "1:398732736665:android:c6411461b41cd814c4a008",
          messagingSenderId: "398732736665",
          projectId: "movies-6f504"));
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(
          create: (_) => AuthService(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Routes',
        initialRoute: MyRoutes.homeRoute,
        routes: {
          MyRoutes.homeRoute: (context) => Wrapper(),
          MyRoutes.loginRoute: (context) => LoginScreen(),
          MyRoutes.movieDetailsRoute: (context) =>
              const MovieList(keyValue: "batman"),
        },
      ),
    );
  }
}
