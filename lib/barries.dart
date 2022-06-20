import 'package:flutter/material.dart';

class MyBarrier extends StatelessWidget {
  final double size;
  final Color color;

  const MyBarrier({Key? key, required this.size, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: size,
      decoration: BoxDecoration(
        color: Colors.green,
        border: Border.all(
          width: 7,
          color: color,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
