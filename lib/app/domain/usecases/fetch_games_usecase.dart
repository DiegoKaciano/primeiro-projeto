import 'package:jogos_zerados/app/domain/entities/game_entity.dart';
import 'package:jogos_zerados/app/domain/repositories/game_repository.dart';
import 'package:jogos_zerados/app/injector.dart';

class FetchGamesUseCase {
  final repository = injector.get<GameRepository>();

  Future<List<Game>> call([String? search]) async {
    return await repository.fetch(search);
  }
}