import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants/direction.dart';

part 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  GameCubit()
      : super(
          const GameInitial(false),
        );

  void startGame() {
    log("start game");
    emit(
      const GameUnderPlay(
        0,
        0,
        direction.DOWN,
        direction.LEFT,
        0,
        0.4,
        true,
      ),
    );
  }

  bool isPlayerDead() {
    final state = this.state;
    if (state is! GameUnderPlay) return true;
    if (state.ballY >= 1) {
      return true;
    }
    return false;
  }

  void resetGame() {
    emit(
      const GameFinished(0, 0, direction.DOWN, direction.LEFT, 0, 0.4, false),
    );
  }

  void moveBall() {
    final state = this.state;
    if (state is! GameUnderPlay) return;
    double ballY = state.ballY;
    double ballX = state.ballX;
    // vertical movement
    if (state.ballYDirection == direction.DOWN) {
      ballY += 0.01;
    } else if (state.ballYDirection == direction.UP) {
      ballY -= 0.01;
    }

    //horizontal movement
    if (state.ballXDirection == direction.LEFT) {
      ballX -= 0.01;
    } else if (state.ballXDirection == direction.RIGHT) {
      ballX += 0.01;
    }

    //check for collisions
    // vertical direction
    direction ballYDirection = state.ballYDirection;
    if (state.ballY >= 0.9 &&
        state.playerX <= ballX &&
        state.playerX + state.brickWidth >= state.ballX) {
      ballYDirection = direction.UP;
    } else if (state.ballY <= -0.9) {
      ballYDirection = direction.DOWN;
    }

    //update horizontal direction
    direction ballXDirection = state.ballXDirection;
    if (state.ballX >= 0.9) {
      ballXDirection = direction.LEFT;
    } else if (state.ballX <= -0.9) {
      ballXDirection = direction.RIGHT;
    }

    emit(
      state.copyWith(
        ballY: ballY,
        ballX: ballX,
        ballYDirection: ballYDirection,
        ballXDirection: ballXDirection,
      ),
    );
  }

  void moveLeft() {
    final state = this.state;
    if (state is! GameUnderPlay) return;
    emit(
      state.copyWith(
        playerX: state.playerX - 0.05,
      ),
    );
  }

  void moveRight() {
    final state = this.state;
    if (state is! GameUnderPlay) return;
    emit(
      state.copyWith(
        playerX: state.playerX + 0.05,
      ),
    );
  }
}
