import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
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
  }

  void _setupCubit() {
    gameCubit = BlocProvider.of<GameCubit>(context);
  }

  void _startGame() {
    gameCubit!.startGame();
    Timer.periodic(const Duration(milliseconds: 20), (timer) {
      // move ball
      gameCubit!.moveBall();

      if (gameCubit!.isPlayerDead()) {
        timer.cancel();
        _showDialog();
      }
    });
  }

  void _showDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.deepPurple,
            title: const Center(
              child: Text(
                'PURPLE WON',
                style: TextStyle(color: Colors.white),
              ),
            ),
            actions: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  gameCubit!.resetGame();
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    color: Colors.deepPurple[100],
                    child: Text(
                      'PLAY AGAIN',
                      style: TextStyle(color: Colors.deepPurple[800]),
                    ),
                  ),
                ),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameCubit, GameState>(
      builder: (context, state) {
        log(
          state.toString(),
        );
        if (state is GameInitial) {
          return _intialGameWidget(state);
        } else if (state is GameUnderPlay) {
          return RawKeyboardListener(
            focusNode: FocusNode(),
            // autofocus: true,
            // onKey: (event) {
            //   if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
            //     gameCubit!.moveLeft();
            //   }
            //   if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
            //     gameCubit!.moveRight();
            //   }
            // },
            child: Scaffold(
              backgroundColor: AppColors.scaffoldBackgroundColor,
              body: SafeArea(
                child: Center(
                  child: Column(
                    children: [
                      Expanded(
                        child: Stack(
                          children: [
                            //enemy brick
                            MyBrick(
                              x: state.enemyX,
                              y: -0.95,
                              brickWidth: state.brickWidth,
                              thisIsEnemy: true,
                            ),
                            // player brick
                            MyBrick(
                              x: state.playerX,
                              y: 0.95,
                              brickWidth: state.brickWidth,
                              thisIsEnemy: false,
                            ),
                            //ball
                            MyBall(
                              x: state.ballX,
                              y: state.ballY,
                              gameHasStarted: state.gameHasStarted,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 80,
                        color: Colors.grey[400],
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () {
                                gameCubit!.moveLeft();
                              },
                              child: const Card(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(Icons.keyboard_arrow_left),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                gameCubit!.moveRight();
                              },
                              child: const Card(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(Icons.keyboard_arrow_right),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
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
                x: -0.2,
                y: -0.9,
                brickWidth: 0.4,
                thisIsEnemy: true,
              ),
              //bottom brick
              const MyBrick(
                x: -0.2,
                y: 0.9,
                brickWidth: 0.4,
                thisIsEnemy: false,
              ),
              //ball
              MyBall(
                x: 0,
                y: 0,
                gameHasStarted: state.gameHasStarted,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
