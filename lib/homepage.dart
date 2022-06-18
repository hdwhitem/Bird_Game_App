import 'dart:async';

import 'package:flutter/material.dart';
import 'package:game_bird_app/barries.dart';
import 'package:game_bird_app/bird.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  static double birdYaxis = 0;
  double time = 0;
  double heigth = 0;
  double initialHeigt = birdYaxis;
  bool gameHasStarted = false;

  void jump() {
    setState(() {
      time = 0;
      initialHeigt = birdYaxis;
    });
  }

  void startGame() {
    gameHasStarted = true;
    Timer.periodic(Duration(milliseconds: 70), (timer) {
      time += 0.05;
      heigth = -4.9 * time * time + 2.8 * time;
      setState(() {
        birdYaxis = initialHeigt - heigth;
      });
      if (birdYaxis > 0.9) {
        timer.cancel();
        gameHasStarted = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Expanded(
          flex: 2,
          child: Stack(
            children: [
              GestureDetector(
                onTap: () {
                  if (gameHasStarted) {
                    jump();
                  } else {
                    startGame();
                  }
                },
                child: AnimatedContainer(
                  alignment: Alignment(0, birdYaxis),
                  color: Colors.blue,
                  duration: Duration(milliseconds: 0),
                  child: MyBird(),
                ),
              ),
              Container(
                alignment: Alignment(0, -0.3),
                child: gameHasStarted
                    ? null
                    : Text(
                        "T A P   T O   P L A Y",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
              ),
              AnimatedContainer(
                duration: Duration(milliseconds: 0),
                alignment: Alignment(0, 1.1),
                child: MyBarrier(size: 200.0),
              ),
              AnimatedContainer(
                duration: Duration(milliseconds: 0),
                alignment: Alignment(0, -1.1),
                child: MyBarrier(size: 200.0),
              ),
            ],
          ),
        ),
        Container(
          height: 15,
          color: Colors.green,
        ),
        Expanded(
            child: Container(
          color: Colors.brown,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "SCORE",
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text("0",
                      style: TextStyle(color: Colors.white, fontSize: 35)),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("BEST",
                      style: TextStyle(color: Colors.white, fontSize: 25)),
                  SizedBox(
                    height: 20,
                  ),
                  Text("0",
                      style: TextStyle(color: Colors.white, fontSize: 35)),
                ],
              ),
            ],
          ),
        ))
      ]),
    );
  }
}
