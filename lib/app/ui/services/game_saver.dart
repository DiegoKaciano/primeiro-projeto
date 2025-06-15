import 'package:flutter/cupertino.dart';
import 'package:jogos_zerados/app/domain/entities/game_entity.dart';
import 'package:jogos_zerados/app/domain/states/games_state.dart';
import 'package:jogos_zerados/app/domain/usecases/create_game_usecase.dart';
import 'package:jogos_zerados/app/domain/usecases/update_game_usecase.dart';
import 'package:jogos_zerados/app/injector.dart';
import 'package:provider/provider.dart';

class GameSaver {
  final createGameUseCase = injector.get<CreateGameUseCase>();
  final updateGameUseCase = injector.get<UpdateGameUseCase>();

  Future<void> saveGame(BuildContext context, Game game) async {
    try {
      final state = Provider.of<GamesState>(context, listen: false);
      final games = state.games.toList();

      if (game.id == null) {
        final newGame = await createGameUseCase.call(game);
        games.add(newGame);
      } else {
        await updateGameUseCase.call(game);
        final index = games.indexWhere((c) => c.id == game.id);
        if(index != -1){
          games[index] = game;
        }
      }
      state.setGames(games);
    } catch (e) {
      print('Error GameSaver');
    }
  }
}