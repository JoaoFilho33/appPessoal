import 'package:flutter/material.dart';
import '../components/ContatosScreen.dart';
import '../components/MenuTabBar.dart';
import '../components/ToDoListScreen.dart';
import '../components/WelcomeScreen.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            MenuTabBar(
              background: Colors.blue,
              iconButtons: [
                IconButton(
                  color: Colors.blue,
                  icon: Icon(Icons.home, size: 30),
                  onPressed: () {},
                ),
                IconButton(
                  color: Colors.blue,
                  icon: Icon(Icons.search, size: 30),
                  onPressed: () {},
                ),
                IconButton(
                  color: Colors.blue,
                  icon: Icon(Icons.map, size: 30),
                  onPressed: () {},
                ),
              ],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: WelcomeScreen(),       
                  ),
                  Container(
                    child: TodoListScreen(),
                  ),
                  Container(
                    child: ContatosScreen(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
