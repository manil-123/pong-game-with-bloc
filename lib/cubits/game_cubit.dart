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
      const Duration(seconds: 10),
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
        state.copyWith(
          ballYDirection: direction.UP,
        ),
      );
    } else if (state.ballY <= -0.9) {
      emit(
        state.copyWith(
          ballYDirection: direction.DOWN,
        ),
      );
    }
  }

  void moveBall() {
    final state = this.state;
    if (state is! GameUnderPlay) return;
    // vertical movement
    if (state.ballYDirection == direction.DOWN) {
      emit(
        state.copyWith(
          ballY: state.ballY + 0.01,
        ),
      );
    } else if (state.ballYDirection == direction.UP) {
      emit(
        state.copyWith(
          ballY: state.ballY - 0.01,
        ),
      );
    }

    //horizontal movement
    if (state.ballXDirection == direction.LEFT) {
      emit(
        state.copyWith(ballX: state.ballX - 0.01),
      );
    } else if (state.ballXDirection == direction.RIGHT) {
      emit(
        state.copyWith(ballX: state.ballX + 0.01),
      );
    }
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
