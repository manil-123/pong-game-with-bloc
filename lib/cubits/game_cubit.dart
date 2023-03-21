import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pong_game/home_page.dart';

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
        true,
      ),
    );
    await Future.delayed(
      const Duration(seconds: 5),
    );
    emit(
      const GameInitial(false),
    );
  }

  void updateBallPosition() {
    final state = this.state;
    if (state is! GameUnderPlay) return;
    emit(
      GameUnderPlay(state.ballX, state.ballY + 0.1, direction.DOWN, true),
    );
  }
}
