import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lumineux_rewards_app/Dashboard.dart';
import 'package:lumineux_rewards_app/Login.dart';

import 'SplashScreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(const LumineuxApp()));
}

class LumineuxApp extends StatelessWidget {
  const LumineuxApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const InitScreen();
  }
}

class InitScreen extends StatefulWidget {
  const InitScreen({Key? key}) : super(key: key);

  @override
  State<InitScreen> createState() => _InitScreenState();
}

class _InitScreenState extends State<InitScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: <String, WidgetBuilder>{
        Login.tag: (BuildContext context) => const Login(),
        Dashboard.tag: (BuildContext context) => const Dashboard(),
      },
      theme: ThemeData(fontFamily: 'Montserrat'),
      home: const SplashScreen(),
    );
  }
}
