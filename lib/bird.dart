import 'package:flutter/material.dart';

class MyBird extends StatelessWidget {
  const MyBird({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 65,
        width: 65,
        child: Image.asset('assets/images/flappy-bird.png'));
  }
}
