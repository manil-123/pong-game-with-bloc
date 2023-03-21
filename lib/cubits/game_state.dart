part of 'game_cubit.dart';

abstract class GameState extends Equatable {
  final bool gameHasStarted;

  const GameState(this.gameHasStarted);
  @override
  List<Object?> get props => [gameHasStarted];
}

class GameInitial extends GameState {
  const GameInitial(super.gameHasStarted);

  @override
  List<Object?> get props => [gameHasStarted];
}

class GameUnderPlay extends GameState {
  final double ballX;
  final double ballY;
  final direction ballDirection;
  const GameUnderPlay(
    this.ballX,
    this.ballY,
    this.ballDirection,
    super.gameHasStarted,
  );

  @override
  List<Object?> get props => [ballX, ballY, gameHasStarted];
}

class GameFinished extends GameState {
  const GameFinished(super.gameHasStarted);

  @override
  List<Object?> get props => [gameHasStarted];
}
