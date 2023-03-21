import 'package:flutter/material.dart';
import 'package:pong_game/constants/colors.dart';
import 'package:pong_game/views/widgets/ball.dart';
import 'package:pong_game/views/widgets/brick.dart';
import 'package:pong_game/views/widgets/cover_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      body: Center(
        child: Stack(
          children: const [
            //Cover screen
            CoverScreen(),
            //top brick
            MyBrick(
              x: 0,
              y: -0.9,
            ),

            //bottom brick
            MyBrick(
              x: 0,
              y: 0.9,
            ),

            //ball
            MyBall(x: 0, y: 0),
          ],
        ),
      ),
    );
  }
}
