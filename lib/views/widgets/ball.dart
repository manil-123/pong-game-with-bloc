import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';

class MyBall extends StatelessWidget {
  final double? x;
  final double? y;
  const MyBall({
    super.key,
    this.x,
    this.y,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(x!, y!),
      child: Material(
        elevation: 8,
        shape: const CircleBorder(),
        child: CircleAvatar(
          backgroundColor: Colors.grey[100],
          radius: 7,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              color: Colors.white,
              height: 30,
              width: 30,
            ),
          ),
        ),
      ),
    );
  }
}
