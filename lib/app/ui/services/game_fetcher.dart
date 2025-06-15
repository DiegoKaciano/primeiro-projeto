import 'package:flutter/cupertino.dart';
import 'package:jogos_zerados/app/domain/states/games_state.dart';
import 'package:jogos_zerados/app/domain/usecases/fetch_games_usecase.dart';
import 'package:jogos_zerados/app/injector.dart';
import 'package:provider/provider.dart';

class GameFetcher {
  final fetchGamesUseCase = injector.get<FetchGamesUseCase>();

  Future<void> fetchGames(BuildContext context, [String? search]) async {
    try {
      final state = Provider.of<GamesState>(context, listen: false);
      final games = await fetchGamesUseCase.call(search);
      state.setGames(games);
    } catch (e) {
      print('Error fetch');
    }
  }
}