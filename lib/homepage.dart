import 'package:flutter/material.dart';
import 'package:game_bird_app/bird.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Expanded(
          flex: 2,
          child: Container(
            color: Colors.blue,
            child: Center(
              child: MyBird(),
            ),
          ),
        ),
        Expanded(
            child: Container(
          color: Colors.green,
        ))
      ]),
    );
  }
}
