import 'package:flutter/material.dart';

import 'barries.dart';
import 'bird.dart';

class Game extends StatelessWidget {
  final double birdYaxis;
  final bool gameHasStarted;
  final double barrierXone;
  final double barrierXtwo;
  final double barrierXthree;
  final double barrierXfour;
  final int score;
  final int bestScore;

  const Game({
    Key? key,
    required this.birdYaxis,
    required this.gameHasStarted,
    required this.barrierXone,
    required this.barrierXtwo,
    required this.barrierXthree,
    required this.barrierXfour,
    required this.score,
    required this.bestScore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
