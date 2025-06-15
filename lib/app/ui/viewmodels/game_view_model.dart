import 'package:flutter/cupertino.dart';
import 'package:jogos_zerados/app/domain/entities/game_entity.dart';
import 'package:jogos_zerados/app/injector.dart';
import 'package:jogos_zerados/app/ui/services/game_deleter.dart';
import 'package:jogos_zerados/app/ui/services/game_fetcher.dart';
import 'package:jogos_zerados/app/ui/services/game_fetcher_status.dart';
import 'package:jogos_zerados/app/ui/services/game_saver.dart';

class GameViewModel {
  final gameFetcher = injector.get<GameFetcher>();
  final gameSaver = injector.get<GameSaver>();
  final gameDeleter = injector.get<GameDeleter>();
  final gameFetcherStatus = injector.get<GameFetcherStatus>();

  Future<void> fetchGames(BuildContext context, [String? search]) async {
    await gameFetcher.fetchGames(context, search);
  }

  Future<void> saveGame(BuildContext context, Game game) async {
    await gameSaver.saveGame(context, game);
  }

  Future<void> deleteGame(BuildContext context, Game game) async {
    await gameDeleter.deleteGame(context, game);
  }

  Future<String> fetchStatus(int idConsole) async {
    final result = await gameFetcherStatus.fetchStatus(idConsole);
    return result;
  }
}