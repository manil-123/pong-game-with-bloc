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
  // for ball
  final double ballX;
  final double ballY;
  final direction ballYDirection;
  final direction ballXDirection;
  // for player brick
  final double playerX;
  const GameUnderPlay(
    this.ballX,
    this.ballY,
    this.ballYDirection,
    this.ballXDirection,
    this.playerX,
    super.gameHasStarted,
  );

  @override
  List<Object?> get props =>
      [ballX, ballY, ballYDirection, ballXDirection, playerX, gameHasStarted];
}

class GameFinished extends GameState {
  const GameFinished(super.gameHasStarted);

  @override
  List<Object?> get props => [gameHasStarted];
}
