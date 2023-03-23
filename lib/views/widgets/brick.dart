import 'package:flutter/material.dart';
import 'package:pong_game/brick.dart';

class MyBrick extends StatelessWidget {
  final double? x;
  final double? y;
  final double brickWidth;
  const MyBrick({
    super.key,
    required this.x,
    required this.y,
    required this.brickWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(x!, y!),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          color: Colors.white,
          height: 20,
          width: MediaQuery.of(context).size.width / 5,
        ),
      ),
    );
  }
}
