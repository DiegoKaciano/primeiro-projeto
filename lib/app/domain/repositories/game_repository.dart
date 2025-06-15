import 'package:jogos_zerados/app/domain/entities/game_entity.dart';

abstract class GameRepository {
  Future<List<Game>> fetch([String? search]);

  Future<Game> read(int id);

  Future<Game> create(Game game);

  Future<void> update(Game game);

  Future<void> delete(Game game);

  Future<int> fetchStatus(int idConsole);
}