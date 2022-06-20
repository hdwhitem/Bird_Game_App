import 'dart:async';

import 'package:flutter/material.dart';
import 'package:game_bird_app/game.dart';
import 'package:just_audio/just_audio.dart';

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

      if (birdYaxis > 0.95) {
        player.setAsset('assets/mp3/game-over.mp3');
        player.play();
        timer.cancel();
        dialogBox(context);
      }

      if ((barrierXthree >= -0.3 && barrierXthree < 0.4) && birdYaxis > 0.43) {
        player.setAsset('assets/mp3/game-over.mp3');
        player.play();
        timer.cancel();
        dialogBox(context);
      }
      if ((barrierXfour >= -0.3 && barrierXfour < 0.4) && birdYaxis < -0.42) {
        player.setAsset('assets/mp3/game-over.mp3');
        player.play();
        timer.cancel();
        dialogBox(context);
      }
      if ((barrierXone >= -0.3 && barrierXone < 0.4) && birdYaxis > 0.43) {
        player.setAsset('assets/mp3/game-over.mp3');
        player.play();
        timer.cancel();
        dialogBox(context);
      }
      if ((barrierXtwo >= -0.3 && barrierXtwo < 0.4) && birdYaxis < -0.42) {
        player.setAsset('assets/mp3/game-over.mp3');
        player.play();
        timer.cancel();
        dialogBox(context);
      }
    });
  }

  late AudioPlayer player;
  @override
  void initState() {
    super.initState();
    player = AudioPlayer();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          if (gameHasStarted) {
            player.setAsset('assets/mp3/jumping.mp3');
            player.play();
            jump();
          } else {
            player.setAsset('assets/mp3/jumping.mp3');
            player.play();
            startGame();
          }
        },
        child: Game(
          birdYaxis: birdYaxis,
          gameHasStarted: gameHasStarted,
          barrierXone: barrierXone,
          barrierXtwo: barrierXtwo,
          barrierXthree: barrierXthree,
          barrierXfour: barrierXfour,
          score: score,
          bestScore: bestScore,
        ));
  }
}
