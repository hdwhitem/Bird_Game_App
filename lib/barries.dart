import 'package:flutter/material.dart';

class MyBarrier extends StatelessWidget {
  final double size;

  const MyBarrier({Key? key, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: size,
      decoration: BoxDecoration(
        color: Colors.green,
        border: Border.all(
          width: 7,
          color: Colors.green[800] as Color,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
