import 'package:flutter/material.dart';
import 'package:flutter_my_stack/firestore_auth.dart';
import 'showScreen.dart';
import 'login_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
    '/' : (context) => LoginScreen(),
    'welcome': (context)=> ShowScreen(),
    }


    );
  }
}
