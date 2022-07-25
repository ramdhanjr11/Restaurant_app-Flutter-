import 'package:flutter/material.dart';

import 'styles/styles.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: textTheme,
      ),
      initialRoute: SplashScreen.routeName,
    );
  }
}

class SplashScreen extends StatelessWidget {
  static const routeName = '/Splash_screen';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}


