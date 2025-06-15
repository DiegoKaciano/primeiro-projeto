import 'dart:convert';

import 'package:jogos_zerados/app/core/database_constants.dart';
import 'package:jogos_zerados/app/data/adapters/bool_adapter.dart';
import 'package:jogos_zerados/app/data/adapters/date_time_adapter.dart';
import 'package:jogos_zerados/app/domain/entities/game_entity.dart';
import 'package:jogos_zerados/app/domain/usecases/get_console_usecase.dart';

class GamesAdapter {
  final dateTimeAdapter = DateTimeAdapter();
  final boolAdapter = BoolAdapter();

  Map<String, dynamic> toMap(Game game) {
    final data = {
      kId: game.id,
      kTitle: game.title,
      kGenre: jsonEncode(game.genres),
      kNamePlatform: game.namePlatform,
      kPlatforms: jsonEncode(game.platforms),
      kIdConsole: game.console.id,
      kGameState: game.gameState,
      kUrlImage: game.urlImage,
      kStartDate: dateTimeAdapter.dateTimeToInt(game.startDate),
      kCompletionDate: dateTimeAdapter.dateTimeToInt(game.completionDate),
      kIsFinished: boolAdapter.boolToInt(game.isFinished),
      kRating: game.rating,
      kNotes: game.notes,
    };
    return data;
  }

  Future<Game> fromMap(Map map) async {
    final genres = List<String>.from(jsonDecode(map[kGenre]));
    final int idConsole = map[kIdConsole];
    final getConsoleUseCase = GetConsoleUseCase();
    final console = await getConsoleUseCase.call(idConsole);
    final platforms = List<String>.from(jsonDecode(map[kPlatforms]));

    return Game(
      id: map[kId],
      title: map[kTitle],
      genres: genres,
      namePlatform: map[kNamePlatform],
      platforms: platforms,
      console: console,
      gameState: map[kGameState],
      urlImage: map[kUrlImage],
      startDate: dateTimeAdapter.intToDateTime(map[kStartDate]),
      completionDate: dateTimeAdapter.intToDateTime(map[kCompletionDate]),
      isFinished: boolAdapter.intToBool(map[kIsFinished]),
      rating: map[kRating],
      notes: map[kNotes],
    );
  }
}
