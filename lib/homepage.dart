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
  static double barrierXone = 1;
  static double barrierXtwo = 1;
  double barrierXthree = barrierXone + 1.5;
  double barrierXfour = barrierXtwo + 1.5;
  var score = 0;
  var bestScore = 0;

  void jump() {
    setState(() {
      time = 0;
      initialHeigt = birdYaxis;
    });
  }

  void restart() {
    setState(() {
      birdYaxis = 0;
      time = 0;
      heigth = 0;
      initialHeigt = birdYaxis;
      barrierXone = 1;
      barrierXtwo = 1;
      barrierXthree = barrierXone + 1.5;
      barrierXfour = barrierXtwo + 1.5;
      gameHasStarted = false;
      score = 0;
    });
  }

  void dialogBox(context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.brown.withOpacity(0.88),
        title: const Text(
          "Game Over",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
        content: Text(
          "You have hit a wall. Score : $score",
          style: const TextStyle(color: Colors.white, fontSize: 18),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              if (bestScore < score) {
                setState(() {
                  bestScore = score;
                });
              }
              restart();
            },
            child: const Text("Replay",
                style: TextStyle(color: Colors.white, fontSize: 18)),
          ),
        ],
      ),
    );
  }

  void startGame() {
    gameHasStarted = true;
    Timer.periodic(const Duration(milliseconds: 90), (timer) {
      time += 0.05;
      heigth = -4.9 * time * time + 2.8 * time;
      setState(() {
        birdYaxis = initialHeigt - heigth;

        if (barrierXone < -2) {
          barrierXone += 3.5;
          score += 1;
        } else {
          barrierXone -= 0.05;
        }

        if (barrierXtwo < -2) {
          barrierXtwo += 3.5;
        } else {
          barrierXtwo -= 0.05;
        }

        if (barrierXthree < -2) {
          barrierXthree += 3.5;
          score += 1;
        } else {
          barrierXthree -= 0.05;
        }

        if (barrierXfour < -2) {
          barrierXfour += 3.5;
        } else {
          barrierXfour -= 0.05;
        }
      });

      if ((barrierXthree >= -0.3 && barrierXthree < 0.4) && birdYaxis > 0.43) {
        timer.cancel();
        dialogBox(context);
      }
      if ((barrierXfour >= -0.3 && barrierXfour < 0.4) && birdYaxis < -0.42) {
        timer.cancel();
        dialogBox(context);
      }
      if ((barrierXone >= -0.3 && barrierXone < 0.4) && birdYaxis > 0.43) {
        timer.cancel();
        dialogBox(context);
      }
      if ((barrierXtwo >= -0.3 && barrierXtwo < 0.4) && birdYaxis < -0.42) {
        timer.cancel();
        dialogBox(context);
      }
      if (birdYaxis > 0.95) {
        timer.cancel();
        dialogBox(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (gameHasStarted) {
          jump();
        } else {
          startGame();
        }
      },
      child: Scaffold(
        body: Column(children: [
          Expanded(
            flex: 2,
            child: Stack(
              children: [
                AnimatedContainer(
                  alignment: Alignment(0, birdYaxis),
                  color: Colors.blue,
                  duration: const Duration(milliseconds: 0),
                  child: const MyBird(),
                ),
                Container(
                  alignment: const Alignment(0, -0.3),
                  child: gameHasStarted
                      ? null
                      : const Text(
                          "T A P   T O   P L A Y",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 0),
                  alignment: Alignment(barrierXone, 1.1),
                  child: const MyBarrier(size: 200.0, color: Colors.pink),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 0),
                  alignment: Alignment(barrierXtwo, -1.1),
                  child: const MyBarrier(size: 200.0, color: Colors.purple),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 0),
                  alignment: Alignment(barrierXthree, 1.1),
                  child: const MyBarrier(size: 200.0, color: Colors.purple),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 0),
                  alignment: Alignment(barrierXfour, -1.1),
                  child: const MyBarrier(size: 200.0, color: Colors.pink),
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
                    const Text(
                      "SCORE",
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text("$score",
                        style:
                            const TextStyle(color: Colors.white, fontSize: 35)),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("BEST",
                        style: TextStyle(color: Colors.white, fontSize: 25)),
                    const SizedBox(
                      height: 20,
                    ),
                    Text("$bestScore",
                        style:
                            const TextStyle(color: Colors.white, fontSize: 35)),
                  ],
                ),
              ],
            ),
          ))
        ]),
      ),
    );
  }
}
