import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pong_game/constants/colors.dart';
import 'package:pong_game/cubits/game_cubit.dart';
import 'package:pong_game/views/widgets/ball.dart';
import 'package:pong_game/views/widgets/brick.dart';
import 'package:pong_game/views/widgets/cover_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GameCubit? gameCubit;
  @override
  void initState() {
    super.initState();
    _setupCubit();
    _startGame();
  }

  void _setupCubit() {
    gameCubit = BlocProvider.of<GameCubit>(context);
  }

  void _startGame() {
    gameCubit!.startGame();
    Timer.periodic(const Duration(milliseconds: 100), (timer) {
      // move ball
      gameCubit!.moveBall();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameCubit, GameState>(
      builder: (context, state) {
        log(state.props.toString());

        if (state is GameInitial) {
          return _intialGameWidget(state);
        } else if (state is GameUnderPlay) {
          return RawKeyboardListener(
            focusNode: FocusNode(),
            autofocus: true,
            onKey: (event) {
              if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
                gameCubit!.moveLeft();
              }
              if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
                gameCubit!.moveRight();
              }
            },
            child: Scaffold(
              backgroundColor: AppColors.scaffoldBackgroundColor,
              body: Center(
                child: Stack(
                  children: [
                    //top brick
                    MyBrick(
                      x: 0,
                      y: -0.9,
                      brickWidth: state.brickWidth,
                    ),
                    // player brick
                    MyBrick(
                      x: state.playerX,
                      y: 0.9,
                      brickWidth: state.brickWidth,
                    ),
                    //ball
                    MyBall(x: state.ballX, y: state.ballY),
                  ],
                ),
              ),
            ),
          );
        }
        return Container();
      },
    );
  }

  Widget _intialGameWidget(GameState state) {
    return GestureDetector(
      onTap: _startGame,
      child: Scaffold(
        backgroundColor: AppColors.scaffoldBackgroundColor,
        body: Center(
          child: Stack(
            children: [
              //Cover screen
              CoverScreen(
                gameHasStarted: state.gameHasStarted,
              ),
              //top brick
              const MyBrick(
                x: 0,
                y: -0.9,
                brickWidth: 0.4,
              ),
              //bottom brick
              const MyBrick(
                x: 0,
                y: 0.9,
                brickWidth: 0.4,
              ),
              //ball
              const MyBall(x: 0, y: 0),
            ],
          ),
        ),
      ),
    );
  }
}
