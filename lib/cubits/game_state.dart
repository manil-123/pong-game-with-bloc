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
  final double enemyX;
  final double brickWidth;
  const GameUnderPlay(
    this.ballX,
    this.ballY,
    this.ballYDirection,
    this.ballXDirection,
    this.playerX,
    this.enemyX,
    this.brickWidth,
    super.gameHasStarted,
  );

  @override
  List<Object?> get props => [
        ballX,
        ballY,
        ballYDirection,
        ballXDirection,
        playerX,
        enemyX,
        brickWidth,
        gameHasStarted
      ];

  GameUnderPlay copyWith({
    double? ballX,
    double? ballY,
    direction? ballYDirection,
    direction? ballXDirection,
    double? playerX,
    double? enemyX,
  }) {
    return GameUnderPlay(
      ballX ?? this.ballX,
      ballY ?? this.ballY,
      ballYDirection ?? this.ballYDirection,
      ballXDirection ?? this.ballXDirection,
      playerX ?? this.playerX,
      enemyX ?? this.enemyX,
      brickWidth,
      gameHasStarted,
    );
  }
}

// class GameFinished extends GameState {
//   final double ballX;
//   final double ballY;
//   final direction ballYDirection;
//   final direction ballXDirection;
//   // for player brick
//   final double playerX;
//   final double brickWidth;
//   const GameFinished(
//     this.ballX,
//     this.ballY,
//     this.ballYDirection,
//     this.ballXDirection,
//     this.playerX,
//     this.brickWidth,
//     super.gameHasStarted,
//   );

//   @override
//   List<Object?> get props => [
//         ballX,
//         ballY,
//         ballYDirection,
//         ballXDirection,
//         playerX,
//         brickWidth,
//         gameHasStarted
//       ];
// }
