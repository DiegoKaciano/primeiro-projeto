import 'package:flutter/cupertino.dart';
import 'package:jogos_zerados/app/domain/entities/game_entity.dart';
import 'package:jogos_zerados/app/domain/repositories/game_repository.dart';
import 'package:jogos_zerados/app/injector.dart';

abstract class GamesStates {}

class InitialGameState extends GamesStates {}

class LoadingGameState extends GamesStates {}

class SuccessGameState extends GamesStates {
  final List<Game> games;
  SuccessGameState(this.games);
}

class ErrorGameState extends GamesStates {
  final String message;
  ErrorGameState(this.message);
}


class GameStore extends ValueNotifier<GamesStates> {
  GameStore(super.value);

  final repository = injector.get<GameRepository>();

  Future<void> fetchGames() async {
    value = LoadingGameState();
    await Future.delayed(Duration(seconds: 2));
    try {
      final games = await repository.fetch();
      value = SuccessGameState(games);
    } catch (e) {
      value = ErrorGameState(e.toString());
    }
  }

  Future<void> putGame(Game game) async {
    try {
      final games = await repository.fetch();
      final list = games.toList();

      final index = list.indexWhere((c) => c.id == game.id);
      if (index == -1) {
        await repository.create(game);
        list.add(game);
      } else {
        await repository.update(game);
        list[index] = game;
      }
      value = SuccessGameState(list);
    } catch (e) {
      value = ErrorGameState(e.toString());
    }
  }
}