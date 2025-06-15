import 'package:flutter/cupertino.dart';
import 'package:jogos_zerados/app/domain/entities/game_entity.dart';
import 'package:jogos_zerados/app/domain/states/games_state.dart';
import 'package:jogos_zerados/app/domain/usecases/delete_game_usecase.dart';
import 'package:jogos_zerados/app/injector.dart';
import 'package:provider/provider.dart';

class GameDeleter {
  final deleteGameUseCase = injector.get<DeleteGameUseCase>();

  Future<void> deleteGame(BuildContext context, Game game) async {
    try {
      final state = Provider.of<GamesState>(context, listen: false);
      final games = state.games.toList();
      await deleteGameUseCase.call(game);
      games.remove(game);
      state.setGames(games);
    } catch (e) {
      print('Error GameDeleter');
    }
  }
}