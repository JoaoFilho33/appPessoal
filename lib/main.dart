import 'package:flutter/material.dart';
import 'package:flutter_teste1/components/LoginScreen.dart';
import 'package:flutter_teste1/views/Home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'components/ToDoListScreen.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (content) => LoginScreen(),
        '/home': (content) => Home(),
        '/TodoListScreen': (context) => TodoListScreen(),
      },
    );
  }
}
