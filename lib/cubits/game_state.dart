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
  const GameUnderPlay(super.gameHasStarted);

  @override
  List<Object?> get props => [gameHasStarted];
}

class GameFinished extends GameState {
  const GameFinished(super.gameHasStarted);

  @override
  List<Object?> get props => [gameHasStarted];
}
