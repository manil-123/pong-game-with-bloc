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

  void startGame() async {
    log("start game");
    emit(
      const GameUnderPlay(
        0,
        0,
        direction.DOWN,
        direction.LEFT,
        0,
        true,
      ),
    );
    await Future.delayed(
      const Duration(seconds: 20),
    );
    emit(
      const GameInitial(false),
    );
  }

  void updateDirection() {
    final state = this.state;
    if (state is! GameUnderPlay) return;
    if (state.ballY >= 0.9) {
      emit(
        GameUnderPlay(
          state.ballX,
          state.ballY,
          direction.UP,
          state.ballXDirection,
          state.playerX,
          true,
        ),
      );
    } else if (state.ballY <= -0.9) {
      emit(
        GameUnderPlay(
          state.ballX,
          state.ballY,
          state.ballXDirection,
          direction.DOWN,
          state.playerX,
          true,
        ),
      );
    }
  }

  void updateBallPosition() {
    final state = this.state;
    if (state is! GameUnderPlay) return;
    if (state.ballYDirection == direction.DOWN) {
      emit(
        GameUnderPlay(
          state.ballX,
          state.ballY + 0.01,
          state.ballYDirection,
          state.ballXDirection,
          state.playerX,
          true,
        ),
      );
    } else if (state.ballYDirection == direction.UP) {
      emit(
        GameUnderPlay(
          state.ballX,
          state.ballY - 0.01,
          state.ballYDirection,
          state.ballXDirection,
          state.playerX,
          true,
        ),
      );
    }
  }

  void moveLeft() {
    final state = this.state;
    if (state is! GameUnderPlay) return;
    emit(
      GameUnderPlay(
        state.ballX,
        state.ballY,
        state.ballYDirection,
        state.ballXDirection,
        state.playerX - 0.05,
        true,
      ),
    );
  }

  void moveRight() {
    final state = this.state;
    if (state is! GameUnderPlay) return;
    emit(
      GameUnderPlay(
        state.ballX,
        state.ballY,
        state.ballYDirection,
        state.ballXDirection,
        state.playerX + 0.05,
        true,
      ),
    );
  }
}
