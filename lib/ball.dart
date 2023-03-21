import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';

class Ball extends StatelessWidget {
  final double? x;
  final double? y;
  final bool? gameHasStarted;
  const Ball({this.x, this.y, this.gameHasStarted});

  @override
  Widget build(BuildContext context) {
    return gameHasStarted!
        ? Container(
            alignment: Alignment(x!, y!),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                color: Colors.white,
                height: 14,
                width: 14,
              ),
            ),
          )
        : Container(
            alignment: Alignment(x!, y!),
            child: AvatarGlow(
              endRadius: 60,
              child: Material(
                elevation: 8,
                shape: CircleBorder(),
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
            ),
          );
  }
}
