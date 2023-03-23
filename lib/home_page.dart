// ignore_for_file: constant_identifier_names
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pong_game/views/widgets/ball.dart';
import 'package:pong_game/views/widgets/brick.dart';

// ignore: camel_case_types
enum direction { UP, DOWN, LEFT, RIGHT }

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _gameHasStarted = false;

  //player variable
  double _playerX = -0.2;
  final double _brickWidth = 0.4;

  //enemy variable top brick;
  double _enemyX = -0.2;

  //ball variables
  double _ballX = 0.0;
  double _ballY = 0.0;
  var _ballYDirection = direction.DOWN;
  var _ballXDirection = direction.LEFT;

  void startGame() {
    _gameHasStarted = true;
    Timer.periodic(const Duration(milliseconds: 15), (timer) {
      updateDirection();

      moveBall();
      moveEnemy();

      //check if player is dead
      if (isPlayerDead()) {
        timer.cancel();
        _showDialog();
      }
    });
  }

  moveEnemy() {
    setState(() {
      _enemyX = _ballX;
    });
  }

  void resetGame() {
    Navigator.pop(context);
    setState(() {
      _gameHasStarted = false;
      _ballX = 0.0;
      _ballY = 0.0;
      _playerX = -0.2;
      _enemyX = -0.2;
    });
  }

  bool isPlayerDead() {
    if (_ballY >= 1) {
      return true;
    }
    return false;
  }

  void _showDialog() {
    showDialog(
        context: context,
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
                onTap: resetGame,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    padding: EdgeInsets.all(8),
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

  void updateDirection() {
    //update vertical direction
    setState(() {
      if (_ballY >= 0.9 &&
          _playerX <= _ballX &&
          _playerX + _brickWidth >= _ballX) {
        _ballYDirection = direction.UP;
      } else if (_ballY <= -0.9) {
        _ballYDirection = direction.DOWN;
      }
    });

    //update horizontal direction
    setState(() {
      if (_ballX >= 1) {
        _ballXDirection = direction.LEFT;
      } else if (_ballX <= -1) {
        _ballXDirection = direction.RIGHT;
      }
    });
  }

  void moveBall() {
    //vertical movement
    setState(() {
      if (_ballYDirection == direction.DOWN) {
        _ballY += 0.01;
      } else if (_ballYDirection == direction.UP) {
        _ballY -= 0.01;
      }
    });

    //horizontal movement
    setState(() {
      if (_ballXDirection == direction.LEFT) {
        _ballX -= 0.01;
      } else if (_ballXDirection == direction.RIGHT) {
        _ballX += 0.01;
      }
    });
  }

  void moveLeft() {
    setState(() {
      if (!(_playerX - 0.1 <= -1)) {
        _playerX -= 0.2;
      }
    });
  }

  void moveRight() {
    setState(() {
      if (!(_playerX + _brickWidth >= 1)) {
        _playerX += 0.2;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: startGame,
      child: Scaffold(
        backgroundColor: Colors.grey[900],
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                Expanded(
                  child: Stack(
                    fit: StackFit.passthrough,
                    children: [
                      // CoverScreen(
                      //   gameHasStarted: _gameHasStarted,
                      // ),
                      //top brick
                      MyBrick(
                        x: _enemyX,
                        y: -0.9,
                        brickWidth: _brickWidth,
                        thisIsEnemy: true,
                      ),
                      //bottom brick
                      MyBrick(
                        x: _playerX,
                        y: 0.9,
                        brickWidth: _brickWidth,
                        thisIsEnemy: false,
                      ),

                      //ball

                      MyBall(
                        x: _ballX,
                        y: _ballY,
                        gameHasStarted: _gameHasStarted,
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
                          moveLeft();
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
                          moveRight();
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
}
